#!/usr/bin/perl

use warnings;
use strict;

my $VERSION = "1.0";
my $PROGRAM = "Brain";
my $COPYRIGHT = "Copyright 2009";
my $AUTHOR = "Søren Lund";

print_welcome_screen();

my @colors = qw (red green blue yellow purple cyan);
my %color_keys = map { (substr($_,0,1)) => $_ } @colors;

my @hidden_code = shuffle_colors(@colors);

my $index = 0;
my %hidden_code_index = map { $_ => $index++ } @hidden_code;

my %turns;
my $valid_keys = join('',(keys %color_keys));
my $prompt = " Your guess #%2d [$valid_keys] ";
my @game_history = ();

for (my $turn = 1; $turn <= 10; $turn++) {
  my $guess;
  do {
    printf $prompt,$turn;
    chomp($guess = <>);
    print_rules() if $guess eq "rule";
    $guess = "" if $guess !~ /[$valid_keys]{4}/i;
  } until length($guess) == 4;
  my @guess = map { $color_keys{$_} } split '',$guess;
  my $black_pegs = 0;
  my $white_pegs = 0;
  for (my $index = 0; $index < 4; $index++) {
    if (exists $hidden_code_index{$guess[$index]}) {
      ($hidden_code_index{$guess[$index]} == $index) ?
	$black_pegs++ : $white_pegs++;
    }
  }

  push @game_history,  sprintf ("   %2d %s  Place: %d   Color: %d\n",
				$turn, $guess, $black_pegs, $white_pegs);
  print "\n\nx";
  print $_ foreach @game_history;
  print "\n";

  if ($black_pegs == 4) {
    print "You won! ", join(',',@hidden_code),"\n";
    exit;
  }
}

print join ',', @hidden_code,"\n";
print join ',', (keys %hidden_code_index), "\n";
print join ',', (values %hidden_code_index), "\n";

sub shuffle_colors {
  my @hidden_code = (@_);
  for (1..$#hidden_code) {
    my $index_a = int(rand($#hidden_code));
    my $index_b = int(rand($#hidden_code));
    my $save_color_a = $hidden_code[$index_a];
    $hidden_code[$index_a] = $hidden_code[$index_b];
    $hidden_code[$index_b] = $save_color_a;
  }
  return @hidden_code[1..4];
}

sub print_welcome_screen {
    printf " %s v%s - %s %s\n", $PROGRAM, $VERSION, $COPYRIGHT, $AUTHOR;
    printf " Commands: help, quit\n\n"
}

sub print_horiz_line {
  print " --------------------------------------\n";
}

sub print_header {
  my $title = shift;
  my $indent = 0;
  print_horiz_line;
  $indent = int((38-length($title))/2) unless length($title) > 38;
  printf "%s%s\n", (" " x $indent), $title;
  print_horiz_line;
}

sub print_rules {
  print_header("Rules of the Game");
  print " The computer creates a secret code.\n";
  print " The code consists of four colors.\n";
  print " To win you must guess the secret code\n";
  print " in no more than ten turns.\n";
  print " There are six different colors: White,\n";
  print " Yellow, Red, Green, Blue and Orange.\n";
  print "\n        Press any key to continue";
  <>;
  print "\n";
}
