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
my $prompt = "Code guess %2d [$valid_keys] ";
for (my $turn = 1; $turn <= 1; $turn++) {
  my $guess;
  do {
    printf $prompt,$turn;
    chomp($guess = <>);
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
  print "B" for (1..$black_pegs);
  print "W" for (1..$white_pegs);
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
    printf " Commands: help, quit\n"
}
