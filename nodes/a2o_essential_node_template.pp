# nodes/a2o-essential/a2o_essential_node_template.pp



### General server definitions
node 'a2o_essential_node_template' {

    ### Main definitions - REQUIRED
    #$domain            = 'servers.example.net'
    #$root_email        = 'root@servers.example.net'
    #$root_email_real   = 'admins@example.net'

    ### PuppetMaster - REQUIRED
    #$puppetmaster_ip       = ''
    #$puppetmaster_host     = 'puppetmaster.example.net'
    #$puppetmaster_host_sys = 'puppetmaster.example.net'
    #$puppetmaster_port     = '8140'
    #$puppetmaster_port_sys = '18140'


    ### Networking definition - REQUIRED
    #$net_ns                   = ['10.1.2.1', '127.0.0.1']
    #$net_primary_network      = '10.1.2.0'
    #$net_primary_network_name = 'example-net'
    #$net_primary_netmask      = '255.255.255.0'
    #$net_primary_broadcast    = '10.1.2.255'
    #$net_primary_gateway      = '10.1.2.250'


    ### Nagios host data - REQUIRED
    #$nagios_ip = ''


    ### Management IPs - REQUIRED
    #$net_management_sources = []


    ### Bind cluster - REQUIRED
    #$named_acl_transfer = '1.1.1.1/32; 1.1.1.2/32;'


    ### Ganglia cluster - REQUIRED
    $ganglia_headnode_ips = ['89.212.63.130', '89.212.63.131']
    $ganglia_cluster_name = 's.itsis.si'


    ### MySQL credentials - REQUIRED?
    #$mysql_root_username        = 'root'
    #$mysql_root_password        = ''
    #$mysql_root_password_hash   = ''
    #$mysql_puppet_username      = 'puppet'
    #$mysql_puppet_password      = ''
    #$mysql_puppet_password_hash = ''
    #$mysql_backup_username      = 'backup'
    #$mysql_backup_password      = ''
    #$mysql_backup_password_hash = ''
    #$mysql_nagios_username      = 'nagios'
    #$mysql_nagios_host          = "$nagios_ip"
    #$mysql_nagios_password      = ''
    #$mysql_nagios_password_hash = ''
    #$mysql_test_username        = 'test'
    #$mysql_test_password        = ''
    #$mysql_test_password_hash   = ''


    ### Default machine configuration
    $net_primary_device = 'eth0'
    $cpu_cores          = '1'
    $mem_kb             = '513628'
    $net_devices        = ['lo', 'br0']
}
