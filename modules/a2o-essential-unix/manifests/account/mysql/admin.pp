###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) Bostjan Skufca                                            #
#-------------------------------------------------------------------------#
# This source file is subject to version 2.0 of the Apache License,       #
# that is bundled with this package in the file LICENSE, and is           #
# available through the world-wide-web at the following url:              #
# http://www.apache.org/licenses/LICENSE-2.0                              #
#-------------------------------------------------------------------------#
# Authors: Bostjan Skufca <my_name [at] a2o {dot} si>                     #
###########################################################################



define   a2o-essential-unix::account::mysql::admin   ($ensure='present', $password) {

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
        create_view_priv      => true,
        show_view_priv        => true,
        reload_priv           => true,
        shutdown_priv         => true,
        grant_priv            => true,
        super_priv            => true,
        execute_priv          => true,
        repl_slave_priv       => true,
        repl_client_priv      => true,
        create_routine_priv   => true,
        alter_routine_priv    => true,
        create_user_priv      => true,
        event_priv            => true,
        trigger_priv          => true,
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
