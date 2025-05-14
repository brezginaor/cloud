output "serverip" {
  value = openstack_compute_instance_v2.brezgina_server.network[0].fixed_ip_v4
}
