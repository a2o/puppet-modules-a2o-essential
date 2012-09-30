<?php // vim:fenc=utf-8:filetype=php:ts=4
/*
 * Copyright (C) 2009  Bruno Prémont <bonbons AT linux-vserver.org>
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; only version 2 of the License is applicable.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

function load_graph_definitions_local($logarithmic = false, $tinylegend = false) {
	global $GraphDefs, $MetaGraphDefs;

	// Define 1-rrd Graph definitions here
	$GraphDefs['local_type'] = array(
		'-v', 'Commits',
		'DEF:avg={file}:value:AVERAGE',
		'DEF:min={file}:value:MIN',
		'DEF:max={file}:value:MAX',
		"AREA:max#B7B7F7",
		"AREA:min#FFFFFF",
		"LINE1:avg#0000FF:Commits",
		'GPRINT:min:MIN:%6.1lf Min,',
		'GPRINT:avg:AVERAGE:%6.1lf Avg,',
		'GPRINT:max:MAX:%6.1lf Max,',
		'GPRINT:avg:LAST:%6.1lf Last\l');

	// COLOR DEFINITIONS
        $Canvas     = 'FFFFFF';

	$FullYellow = 'F0A000';
	$FullOrange = 'FFA000';
        $FullRed    = 'FF0000';
	$FullMagenta= 'A000FF';
        $FullCyan   = '00A0FF';
        $FullBlue   = '0000FF';
	$FullGreen  = '00E000';

	$HalfYellow = 'F3DFB7';
        $HalfOrange = 'FFDFB7';
        $HalfRed    = 'F7B7B7';
	$HalfMagenta= 'DFB7F7';
        $HalfCyan   = 'B7DFF7';
        $HalfBlue   = 'B7B7F7';
	$HalfGreen  = 'B7EFB7';

        $HalfBlueGreen = '89B3C9';


	// Graph definitions: APACHE
        $GraphDefs['apache_idle_workers'] = array(
		'-v', 'Idle workers',
		'DEF:min={file}:value:MIN',
		'DEF:avg={file}:value:AVERAGE',
		'DEF:max={file}:value:MAX',
		"AREA:max#$HalfGreen",
		"AREA:min#$Canvas",
		"LINE1:avg#$FullGreen:Idle workers",
		'GPRINT:min:MIN:%6.2lf Min,',
		'GPRINT:avg:AVERAGE:%6.2lf Avg,',
		'GPRINT:max:MAX:%6.2lf Max,',
		'GPRINT:avg:LAST:%6.2lf Last');
        $GraphDefs['apache_connections'] = array(
		'-v', 'Connections',
		'DEF:min={file}:value:MIN',
		'DEF:avg={file}:value:AVERAGE',
		'DEF:max={file}:value:MAX',
		"AREA:max#$HalfYellow",
		"AREA:min#$Canvas",
		"LINE1:avg#$FullYellow:Connections",
		'GPRINT:min:MIN:%6.2lf Min,',
		'GPRINT:avg:AVERAGE:%6.2lf Avg,',
		'GPRINT:max:MAX:%6.2lf Max,',
		'GPRINT:avg:LAST:%6.2lf Last');


	// Graph definitions: MYSQL
	$GraphDefs['mysql_locks'] = array(
		'-v', 'Locks per second',
		'DEF:ml_avg={file}:value:AVERAGE',
		'DEF:ml_min={file}:value:MIN',
		'DEF:ml_max={file}:value:MAX',
		"AREA:ml_max#$HalfYellow",
		"AREA:ml_min#$Canvas",
		"LINE1:ml_avg#$FullYellow:MySQL locks",
		'GPRINT:ml_min:MIN:%4.1lf Min,',
		'GPRINT:ml_avg:AVERAGE:%4.1lf Avg,',
		'GPRINT:ml_max:MAX:%4.1lf Max,',
		'GPRINT:ml_avg:LAST:%4.1lf Last');


	// Graph definitions: Memcached
	$GraphDefs['memcached_command'] = array(
		'-v', 'Commands per second',
		'DEF:mc_avg={file}:value:AVERAGE',
		'DEF:mc_min={file}:value:MIN',
		'DEF:mc_max={file}:value:MAX',
		"AREA:mc_max#$HalfGreen",
		"AREA:mc_min#$Canvas",
		"LINE1:mc_avg#$FullGreen:Memcached commands",
		'GPRINT:mc_min:MIN:%4.1lf Min,',
		'GPRINT:mc_avg:AVERAGE:%4.1lf Avg,',
		'GPRINT:mc_max:MAX:%4.1lf Max,',
		'GPRINT:mc_avg:LAST:%4.1lf Last');
	$GraphDefs['memcached_connections'] = array(
		'-v', 'Connections open',
		'DEF:mc_avg={file}:value:AVERAGE',
		'DEF:mc_min={file}:value:MIN',
		'DEF:mc_max={file}:value:MAX',
		"AREA:mc_max#$HalfBlue",
		"AREA:mc_min#$Canvas",
		"LINE1:mc_avg#$FullBlue:Memcached connections",
		'GPRINT:mc_min:MIN:%4.1lf Min,',
		'GPRINT:mc_avg:AVERAGE:%4.1lf Avg,',
		'GPRINT:mc_max:MAX:%4.1lf Max,',
		'GPRINT:mc_avg:LAST:%4.1lf Last');
	$GraphDefs['memcached_items'] = array(
		'-v', 'Items in cache',
		'DEF:val_avg={file}:value:AVERAGE',
		'DEF:val_min={file}:value:MIN',
		'DEF:val_max={file}:value:MAX',
		"AREA:val_max#$HalfBlue",
		"AREA:val_min#$Canvas",
		"LINE1:val_avg#$FullBlue:Memcached items",
		'GPRINT:val_min:MIN:%4.1lf Min,',
		'GPRINT:val_avg:AVERAGE:%4.1lf Avg,',
		'GPRINT:val_max:MAX:%4.1lf Max,',
		'GPRINT:val_avg:LAST:%4.1lf Last',
		);
	$GraphDefs['memcached_octets'] = array(
		'-v', 'Bytes transferred per second',
		'DEF:tx_max={file}:tx:MAX',
		'DEF:tx_min={file}:tx:MIN',
		'DEF:tx_avg={file}:tx:AVERAGE',
		'DEF:rx_max={file}:rx:MAX',
		'DEF:rx_min={file}:rx:MIN',
		'DEF:rx_avg={file}:rx:AVERAGE',
		"AREA:tx_max#$HalfGreen",
		"AREA:tx_min#$Canvas",
		"AREA:rx_max#$HalfRed",
		"AREA:rx_min#$Canvas",
		"LINE1:rx_avg#$FullRed:Memcached bytes per second RX",
		"LINE1:tx_avg#$FullGreen:Memcached bytes per second TX",
		);
	$GraphDefs['memcached_ops'] = array(
		'-v', 'Operations',
		'DEF:val_avg={file}:value:AVERAGE',
		'DEF:val_min={file}:value:MIN',
		'DEF:val_max={file}:value:MAX',
		"AREA:val_max#$HalfBlue",
		"AREA:val_min#$Canvas",
		"LINE1:val_avg#$FullBlue:Memcached items",
		'GPRINT:val_min:MIN:%4.1lf Min,',
		'GPRINT:val_avg:AVERAGE:%4.1lf Avg,',
		'GPRINT:val_max:MAX:%4.1lf Max,',
		'GPRINT:val_avg:LAST:%4.1lf Last',
		);



	// Graph definitions: NTPD
        $GraphDefs['frequency_offset'] = array(
		'DEF:ppm_avg={file}:value:AVERAGE',
		'DEF:ppm_min={file}:value:MIN',
		'DEF:ppm_max={file}:value:MAX',
		"AREA:ppm_max#$HalfBlue",
		"AREA:ppm_min#$Canvas",
		"LINE1:ppm_avg#$FullBlue:Offset",
		'GPRINT:ppm_min:MIN:%5.2lf Min,',
		'GPRINT:ppm_avg:AVERAGE:%5.2lf Avg,',
		'GPRINT:ppm_max:MAX:%5.2lf Max,',
		'GPRINT:ppm_avg:LAST:%5.2lf Last'
		);
        $GraphDefs['delay'] = array(
                'DEF:s_avg={file}:value:AVERAGE',
                'DEF:s_min={file}:value:MIN',
                'DEF:s_max={file}:value:MAX',
                "AREA:s_max#$HalfBlue",
                "AREA:s_min#$Canvas",
                "LINE1:s_avg#$FullBlue:Delay",
                'GPRINT:s_min:MIN:%7.3lf%s Min,',
                'GPRINT:s_avg:AVERAGE:%7.3lf%s Avg,',
                'GPRINT:s_max:MAX:%7.3lf%s Max,',
                'GPRINT:s_avg:LAST:%7.3lf%s Last'
		);
        $GraphDefs['time_dispersion'] = array(
                'DEF:s_avg={file}:value:AVERAGE',
                'DEF:s_min={file}:value:MIN',
                'DEF:s_max={file}:value:MAX',
                "AREA:s_max#$HalfBlue",
                "AREA:s_min#$Canvas",
                "LINE1:s_avg#$FullBlue:Seconds",
                'GPRINT:s_min:MIN:%7.3lf%s Min,',
                'GPRINT:s_avg:AVERAGE:%7.3lf%s Avg,',
                'GPRINT:s_max:MAX:%7.3lf%s Max,',
                'GPRINT:s_avg:LAST:%7.3lf%s Last'
		);
        $GraphDefs['time_offset'] = array(
		'DEF:s_avg={file}:value:AVERAGE',
		'DEF:s_min={file}:value:MIN',
		'DEF:s_max={file}:value:MAX',
		"AREA:s_max#$HalfBlue",
		"AREA:s_min#$Canvas",
		"LINE1:s_avg#$FullBlue:Seconds",
		'GPRINT:s_min:MIN:%7.3lf%s Min,',
		'GPRINT:s_avg:AVERAGE:%7.3lf%s Avg,',
		'GPRINT:s_max:MAX:%7.3lf%s Max,',
		'GPRINT:s_avg:LAST:%7.3lf%s Last');



	// Graph definitions: PING
	$GraphDefs['ping'] = array(
		'-v', 'Miliseconds',
		'DEF:ping_avg={file}:ping:AVERAGE',
		'DEF:ping_min={file}:ping:MIN',
		'DEF:ping_max={file}:ping:MAX',
		"AREA:ping_max#$HalfBlue",
		"AREA:ping_min#$Canvas",
		"LINE1:ping_avg#$FullBlue:Ping response time",
		'GPRINT:ping_min:MIN:%4.1lf ms Min,',
		'GPRINT:ping_avg:AVERAGE:%4.1lf ms Avg,',
		'GPRINT:ping_max:MAX:%4.1lf ms Max,',
		'GPRINT:ping_avg:LAST:%4.1lf ms Last');
	$GraphDefs['ping_droprate'] = array(
		'DEF:ping_droprate_avg={file}:value:AVERAGE',
		'DEF:ping_droprate_min={file}:value:MIN',
		'DEF:ping_droprate_max={file}:value:MAX',
		"AREA:ping_droprate_max#$HalfRed",
		"AREA:ping_droprate_min#$Canvas",
		"LINE1:ping_droprate_avg#$FullRed:Ping droprate",
		'GPRINT:ping_droprate_min:MIN:%4.1lf Min,',
		'GPRINT:ping_droprate_avg:AVERAGE:%4.1lf Avg,',
		'GPRINT:ping_droprate_max:MAX:%4.1lf Max,',
		'GPRINT:ping_droprate_avg:LAST:%4.1lf Last');
	$GraphDefs['ping_stddev'] = array(
		'-v', 'Miliseconds',
		'DEF:ping_stddev_avg={file}:value:AVERAGE',
		'DEF:ping_stddev_min={file}:value:MIN',
		'DEF:ping_stddev_max={file}:value:MAX',
		"AREA:ping_stddev_max#$HalfGreen",
		"AREA:ping_stddev_min#$Canvas",
		"LINE1:ping_stddev_avg#$FullGreen:Ping time standard deviation",
		'GPRINT:ping_stddev_min:MIN:%4.1lf ms Min,',
		'GPRINT:ping_stddev_avg:AVERAGE:%4.1lf ms Avg,',
		'GPRINT:ping_stddev_max:MAX:%4.1lf ms Max,',
		'GPRINT:ping_stddev_avg:LAST:%4.1lf ms Last');

	// Graph definitions: PROCESS
	$GraphDefs['ps_code'] = array(
		'-v', 'Bytes', '-b', '1024',
		'DEF:ps_code_avg={file}:value:AVERAGE',
		'DEF:ps_code_min={file}:value:MIN',
		'DEF:ps_code_max={file}:value:MAX',
		"AREA:ps_code_max#$HalfYellow",
		"AREA:ps_code_min#$Canvas",
		"LINE1:ps_code_avg#$FullYellow:Code",
		'GPRINT:ps_code_min:MIN:%4.1lf %sBytes Min,',
		'GPRINT:ps_code_avg:AVERAGE:%4.1lf %sBytes Avg,',
		'GPRINT:ps_code_max:MAX:%4.1lf %sBytes Max,',
		'GPRINT:ps_code_avg:LAST:%4.1lf %sBytes Last');
	$GraphDefs['ps_data'] = array(
		'-v', 'Bytes', '-b', '1024',
		'DEF:ps_data_avg={file}:value:AVERAGE',
		'DEF:ps_data_min={file}:value:MIN',
		'DEF:ps_data_max={file}:value:MAX',
		"AREA:ps_data_max#$HalfOrange",
		"AREA:ps_data_min#$Canvas",
		"LINE1:ps_data_avg#$FullOrange:Data",
		'GPRINT:ps_data_min:MIN:%4.1lf %sBytes Min,',
		'GPRINT:ps_data_avg:AVERAGE:%4.1lf %sBytes Avg,',
		'GPRINT:ps_data_max:MAX:%4.1lf %sBytes Max,',
		'GPRINT:ps_data_avg:LAST:%4.1lf %sBytes Last');
	$GraphDefs['ps_stacksize'] = array(
		'-v', 'Bytes', '-b', '1024',
		'DEF:ps_stacksize_avg={file}:value:AVERAGE',
		'DEF:ps_stacksize_min={file}:value:MIN',
		'DEF:ps_stacksize_max={file}:value:MAX',
		"AREA:ps_stacksize_max#$HalfMagenta",
		"AREA:ps_stacksize_min#$Canvas",
		"LINE1:ps_stacksize_avg#$FullMagenta:Stack",
		'GPRINT:ps_stacksize_min:MIN:%4.1lf %sBytes Min,',
		'GPRINT:ps_stacksize_avg:AVERAGE:%4.1lf %sBytes Avg,',
		'GPRINT:ps_stacksize_max:MAX:%4.1lf %sBytes Max,',
		'GPRINT:ps_stacksize_avg:LAST:%4.1lf %sBytes Last');
	$GraphDefs['ps_vm'] = array(
		'-v', 'Bytes', '-b', '1024',
		'DEF:ps_vm_avg={file}:value:AVERAGE',
		'DEF:ps_vm_min={file}:value:MIN',
		'DEF:ps_vm_max={file}:value:MAX',
		"AREA:ps_vm_max#$HalfCyan",
		"AREA:ps_vm_min#$Canvas",
		"LINE1:ps_vm_avg#$FullCyan:Virtual",
		'GPRINT:ps_vm_min:MIN:%4.1lf %sBytes Min,',
		'GPRINT:ps_vm_avg:AVERAGE:%4.1lf %sBytes Avg,',
		'GPRINT:ps_vm_max:MAX:%4.1lf %sBytes Max,',
		'GPRINT:ps_vm_avg:LAST:%4.1lf %sBytes Last');
	$GraphDefs['fork_rate'] = array(
		'-v', 'Forks per second',
		'--logarithmic',
		'DEF:ps_fr_avg={file}:value:AVERAGE',
		'DEF:ps_fr_min={file}:value:MIN',
		'DEF:ps_fr_max={file}:value:MAX',
		"AREA:ps_fr_max#$HalfGreen",
		"AREA:ps_fr_min#$Canvas",
		"LINE1:ps_fr_avg#$FullGreen:Fork rate",
		'GPRINT:ps_fr_min:MIN:%4.1lf forks Min,',
		'GPRINT:ps_fr_avg:AVERAGE:%4.1lf forks Avg,',
		'GPRINT:ps_fr_max:MAX:%4.1lf forks Max,',
		'GPRINT:ps_fr_avg:LAST:%4.1lf forks Last');

	// Graph definitions: PROTOCOLS
	$GraphDefs['protocol_counter'] = array(
		'DEF:pc_avg={file}:value:AVERAGE',
		'DEF:pc_min={file}:value:MIN',
		'DEF:pc_max={file}:value:MAX',
		"AREA:pc_max#$HalfGreen",
		"AREA:pc_min#$Canvas",
		"LINE1:pc_avg#$FullGreen:Occurences",
		'GPRINT:pc_min:MIN:%4.1lf Min,',
		'GPRINT:pc_avg:AVERAGE:%4.1lf Avg,',
		'GPRINT:pc_max:MAX:%4.1lf Max,',
		'GPRINT:pc_avg:LAST:%4.1lf Last');

	// Graph definitions: SWAP
	$GraphDefs['swap_io'] = array(
		'DEF:sio_avg={file}:value:AVERAGE',
		'DEF:sio_min={file}:value:MIN',
		'DEF:sio_max={file}:value:MAX',
		"AREA:sio_max#$HalfGreen",
		"AREA:sio_min#$Canvas",
		"LINE1:sio_avg#$FullGreen:Swap IO",
		'GPRINT:sio_min:MIN:%4.1lf Min,',
		'GPRINT:sio_avg:AVERAGE:%4.1lf Avg,',
		'GPRINT:sio_max:MAX:%4.1lf Max,',
		'GPRINT:sio_avg:LAST:%4.1lf Last');

	// Graph definitions: UPTIME
	$GraphDefs['uptime'] = array(
		'-v', 'Uptime',
		'DEF:ut_avg={file}:value:AVERAGE',
		'DEF:ut_min={file}:value:MIN',
		'DEF:ut_max={file}:value:MAX',
		"AREA:ut_max#$HalfGreen",
		"AREA:ut_min#$Canvas",
		"LINE1:ut_avg#$FullGreen:Uptime",
		'GPRINT:ut_min:MIN:%4.1lf Min,',
		'GPRINT:ut_avg:AVERAGE:%4.1lf Avg,',
		'GPRINT:ut_max:MAX:%4.1lf Max,',
		'GPRINT:ut_avg:LAST:%4.1lf Last');

	// Define MetaGraph definition type -> function mappings here
	$MetaGraphDefs['local_meta'] = 'meta_graph_local';
}

function meta_graph_local($host, $plugin, $plugin_instance, $type, $type_instances, $opts = array()) {
	global $config;
	$sources = array();

	$title = "$host/$plugin".(!is_null($plugin_instance) ? "-$plugin_instance" : '')."/$type";
	if (!isset($opts['title']))
		$opts['title'] = $title;
	$opts['rrd_opts'] = array('-v', 'Events');

	$files = array();
/*	$opts['colors'] = array(
		'ham'     => '00e000',
		'spam'    => '0000ff',
		'malware' => '990000',

		'sent'     => '00e000',
		'deferred' => 'a0e000',
		'reject'   => 'ff0000',
		'bounced'  => 'a00050'
	);

	$type_instances = array('ham', 'spam', 'malware',  'sent', 'deferred', 'reject', 'bounced'); */
	foreach ($type_instances as $inst) {
		$file  = '';
		foreach ($config['datadirs'] as $datadir)
			if (is_file($datadir.'/'.$title.'-'.$inst.'.rrd')) {
				$file = $datadir.'/'.$title.'-'.$inst.'.rrd';
				break;
			}
		if ($file == '')
			continue;

		$sources[] = array('name'=>$inst, 'file'=>$file);
	}

//	return collectd_draw_meta_stack($opts, $sources);
	return collectd_draw_meta_line($opts, $sources);
}

?>
