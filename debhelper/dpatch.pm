#!/usr/bin/perl
use warnings;
use strict;
use Debian::Debhelper::Dh_Lib;

insert_before("dh_auto_configure", "dh_dpatch_patch");
insert_before("dh_clean", "dh_dpatch_unpatch");

# Eval to avoid problem with debhelper < 7.3.12
eval {
    add_command("dh_dpatch_patch", "patch");
};

1;

