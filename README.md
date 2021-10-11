# terraform_gcp_monitoring

https://github.com/hashicorp/terraform-provider-google/issues/3008


to install this 
1- create a service account to authenticate terraform
2- install Ops agent in all the nodes.https://www.youtube.com/watch?v=Fzd6WP0_bWM  
3- https://cloud.google.com/monitoring/api/metrics_opsagent
4- for the list https://github.com/hashicorp/terraform-provider-google/issues/3008
> resource "google_monitoring_notification_channel" "email" {
>  project = var.project
>  display_name = "Send email to ${var.notification_email_addresses}"
>  type = "email"
>  labels = {
>    email_address = var.notification_email_addresses
>  }
> }
>
> resource "google_monitoring_alert_policy" "disk-usage" {
>  project      = var.project
>  display_name = "Disk usage"
>  enabled      = true
>  combiner     = "OR"

>>  notification_channels = [google_monitoring_notification_channel.email.name
  ]

  conditions {
      display_name = "Free disk space on Adcel Nodes"
       condition_threshold {
        # for more details : filter          = "metric.type=\"agent.googleapis.com/disk/percent_used\" AND resource.type=\"gce_instance\" AND metric.label.\"device\"=\"/dev/sda1 , /dev/sda15\" AND metric.label.\"state\"=\"used or free or ...\""
        filter = "metric.type=\"agent.googleapis.com/disk/percent_used\" AND resource.type=\"gce_instance\" AND metric.label.\"state\"=\"used\"" # metric.label.\"device\"=\"/dev/sda1\""
        duration        =  "60s"
        comparison      =  "COMPARISON_GT"
        threshold_value =  "25"
        trigger {
          count = "1"
        }

        aggregations {
            alignment_period   = "60s"
            per_series_aligner = "ALIGN_MIN"
        }  
      }
    }
}
 
