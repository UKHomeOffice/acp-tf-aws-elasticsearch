data "aws_kms_secrets" "logstash_password" {
  secret {
    name    = "password"
    payload = "AQICAHh2AnE6aCgvxfftcdI8jy1l5Nx2dPXyRD02SNK9DvgsqwElNBXSRH0IbC7kDbspwrn+AAAAbzBtBgkqhkiG9w0BBwagYDBeAgEAMFkGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQM06JCbyppP07am1bJAgEQgCxOmr31Mm4jAheIdcYfTT23zIqVoE49xThkYrPHevT/xj/RI2VWd4PqVDSo4Q=="
  }
}

data "aws_kms_secrets" "proxy_password" {
  secret {
    name    = "password"
    payload = "AQICAHh2AnE6aCgvxfftcdI8jy1l5Nx2dPXyRD02SNK9DvgsqwFRt026sOHQnzUXi/RL8fb/AAAAbzBtBgkqhkiG9w0BBwagYDBeAgEAMFkGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMd4S0Cm+aeoj6sTU3AgEQgCxiDGFOtjeJCdqnNfb/CYnH8Sb/mMIbJBoOir5M/EZAUSUmu/2PlHXvOFRY5A=="
  }
}

