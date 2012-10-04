###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) 2012 Bostjan Skufca                                       #
#-------------------------------------------------------------------------#
# This source file is subject to version 2.0 of the Apache License,       #
# that is bundled with this package in the file LICENSE, and is           #
# available through the world-wide-web at the following url:              #
# http://www.apache.org/licenses/LICENSE-2.0                              #
#-------------------------------------------------------------------------#
# Authors: Bostjan Skufca <my_name [at] a2o {dot} si>                     #
###########################################################################



define   a2o-essential-unix::account::mysql::designer   ($ensure='present', $password) {

    ###
    ### Get user@host from resource name
    ###
    $userHost = "$name"


    ###
    ### Define privileges
    ###
    Mysql_user {
        select_priv           => true,
        insert_priv           => true,
        update_priv           => true,
        delete_priv           => true,
        create_priv           => true,
        drop_priv             => true,
        process_priv          => true,
        file_priv             => true,
        references_priv       => true,
        index_priv            => true,
        alter_priv            => true,
        show_db_priv          => true,
        create_tmp_table_priv => true,
        lock_tables_priv      => true,
        create_view_priv      => false,
        show_view_priv        => true,
        reload_priv           => false,
        shutdown_priv         => false,
        grant_priv            => false,
        super_priv            => false,
        execute_priv          => true,
        repl_slave_priv       => false,
        repl_client_priv      => false,
        create_routine_priv   => false,
        alter_routine_priv    => false,
        create_user_priv      => false,
        event_priv            => false,
        trigger_priv          => false,
#        require               => Service['a2o-linux-mysqld'],
    }


    ###
    ### Define this user instance
    ###
    mysql_user { "$userHost":
	ensure   => "$ensure",
	password => "$password",
    }
}
