
resource "helm_release" "ingress" {
  name       = local.ingress_name
  namespace  = local.ingress_namespace
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = local.ingress_version
  # wait for the certificate validation - https://kubernetes.github.io/ingress-nginx/deploy/#certificate-generation
  wait             = true
  create_namespace = true

  values = [
    yamlencode({
      controller = {
        config = {
          # If true, NGINX passes the incoming "X-Forwarded-*" headers to upstreams.
          # https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#use-forwarded-headers
          # https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/x-forwarded-headers.html
          "use-forwarded-headers" : "true"
        }
        service = {
          # The value "Local" preserves the client source IP.
          # https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer
          externalTrafficPolicy = "Local"

          loadBalancerSourceRanges = var.load_balancer_access_ranges

          enableHttps = local.enable_https_ingress

          targetPorts = {
            # Set the HTTPS listener to accept HTTP connections only, as the AWS load
            # balancer is terminating TLS.
            https = "http"
          }
          annotations = {
            # Whether the LB will be internet-facing or internal.
            # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.3/guide/service/annotations/#lb-internal
            "service.beta.kubernetes.io/aws-load-balancer-internal" : "false"

            # Specifies the IP address type, in this case "dualstack" will allow clients
            # can access the load balancer using either IPv4 or IPv6.
            # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.2/guide/service/annotations/#ip-address-type
            "service.beta.kubernetes.io/aws-load-balancer-ip-address-type" : "dualstack"

            # The protocol to use for backend traffic between the load balancer and the k8s pods.
            # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.3/guide/service/annotations/#backend-protocol
            "service.beta.kubernetes.io/aws-load-balancer-backend-protocol" : "http"
          }
        }
      }
    }),

    # Ingress resources do not support TCP or UDP services. Support is therefore supplied by the Ingress NGINX
    # controller through the --tcp-services-configmap and --udp-services-configmap flags. These flags point to
    # an existing config map where; the key is the external port to use, and the value indicates the service to
    # expose. For more detail see, exposing TCP and UDP services:
    # https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/exposing-tcp-udp-services.md
    #
    # The inclusion of the tcp stanza below will result in the following when the ingress-nginx helm chart is deployed:
    # 1. Creation of a config map, as described above, defining how inbound TCP traffic, on port 7999, should be routed,
    #    and to which backend service
    # 2. Update the controllers deployment, to include the "--tcp-services-configmap" flag pointing to this config map
    # 3. Addition of a port definition for 7999 on the controllers service
    #
    # These 3 steps are effectively what is documented here:
    # https://atlassian.github.io/data-center-helm-charts/examples/bitbucket/BITBUCKET_SSH/#nginx-ingress-controller-config-for-ssh-connections
    #
    # Note: Although the port definition defined in step 3 is done so using the TCP protocol, this protocol is not
    # reflected in the associated ELB Load Balancer. As such, the method "enable_ssh_tcp_protocol_on_lb_listener" (install.sh)
    # is executed, post deployment, to update the protocol on the load balancer from HTTP to TCP.
    #
    local.ssh_tcp_setting,
  ]
}

# To create product specific r53 records we need to expose ingress controller information
data "kubernetes_service" "ingress_nginx" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = helm_release.ingress.metadata[0].namespace
  }
}
