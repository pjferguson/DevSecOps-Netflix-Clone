variable "key" {
    type = string
    description = "Access key for movie data"
    sensitive = true

}

variable "sonarpw" {
    type = string
    description = "Sonar postgres user password"
    sensitive = true
}

variable "dockerus" {
    type = string
    description = "Docker hub username"
    sensitive = true
}

variable "access" {
    type = string
    description = "access token"
    sensitive = true
 }