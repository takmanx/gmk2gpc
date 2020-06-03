#!/usr/bin/env perl
use Data::Dumper;
use warnings;
use POSIX qw(floor ceil);

my $command = {
               '40' => BUTTON_1,
               '41' => BUTTON_2,
               '42' => BUTTON_3,
               '43' => BUTTON_4,
               '44' => BUTTON_5,
               '45' => BUTTON_6,
               '46' => BUTTON_7,
               '47' => BUTTON_8,
               '48' => BUTTON_9,
               '49' => BUTTON_10,
               '4a' => BUTTON_11,
               '4b' => BUTTON_12,
               '4c' => BUTTON_13,
               '4d' => BUTTON_14,
               '4e' => BUTTON_15,
               '4f' => BUTTON_16,
               '50' => BUTTON_17,
               '51' => BUTTON_18,
               '52' => BUTTON_19,
               '53' => BUTTON_20,
               '54' => BUTTON_21,
               '55' => STICK_1_X,
               '56' => STICK_1_Y,
               '57' => STICK_2_X,
               '58' => STICK_2_Y,
               '59' => POINT_1_X,
               '5a' => POINT_1_Y,
               '5b' => POINT_2_X,
               '5c' => POINT_2_Y,
               '5d' => ACCEL_1_X,
               '5e' => ACCEL_1_Y,
               '5f' => ACCEL_1_Z,
               '60' => ACCEL_2_X,
               '61' => ACCEL_2_Y,
               '62' => ACCEL_2_Z,
               '63' => GYRO_1_X,
               '64' => GYRO_1_Y,
               '65' => GYRO_1_Z
              };

sub main {
  my $file = shift @ARGV || "input.gmk";

  if (-f $file) {
    my $size = -s $file;
    my $recnum = int ($size / 5);
    open my $f, "$file" or die "$file: $!\n";
    binmode $f;
    my $val;
    my $buf;
    print "combo sample {\n";
    while (read($f, $val, 5)) {
      $buf = "";
      my $str = unpack("H*", $val); #unsigned byte
      $str =~ s/^(\w{2})//;
      my $i = $1;
      if ($i eq 'c0') {
        # wait
        my $val;
        my $int = hex $str;
        $val = $int;
        $buf = "  wait($val);\n";
        print $buf;
      } elsif (exists $command->{$i}) {
        my $val;
        $str =~ s/(\w{4})(\w{4})//;
        my $int = hex $1;
        my $frac = hex $2;
        if ($int > 65280) {
          #          $int = sprintf "%04x", $int;
          $int = 65536 - $int;
          $int = -1 * $int;
        }
        $frac = sprintf "%02i",ceil($frac / 655.36);
        if ($frac >= 100) {
          $frac = 99;
        }
        $val = $int . "." . $frac;
        if ($val > 100) {
          $val = "100.00";
        } elsif ($val < -100) {
          $val = "-100.00";
        }
        $buf = "  set_val($command->{$i}, $val);\n";
        print $buf;
      } else {
        # unknown code
        # print Dumper "unknown";
      }
    }
    print "}\n";    
    close $f;
  } else {
    print "usage: perl gmk2gpc.pl <input.gmk file>\n\noutput: gpc code\n";
  }
}

main;

=pod
570000970a;
c000000014;
570000851e;
c00000000a;
570000b851;
c00000000a
ff
=cut
