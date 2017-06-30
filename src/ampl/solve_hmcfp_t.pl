#! /usr/local/bin/perl


# Solve the triplet formulations of the hierarchical
# maximum concurrent problem
# Command line argument(s):
#                       1. data file
#                       2. the maximum number of levels (optional)

$argc = @ARGV;
if ($argc < 1) {
    die "Usage: solve_hmcfp_t.pl [data file] [maximum number of levels -optional] \n";
} elsif (not -r $ARGV[0]) {
    die "Can't read the data file $ARGV[0]\n";
} 

$data_file = $ARGV[0];
$file_name = $data_file;
$file_name =~ s/\.txt//;
$file_name =~ s/\.dat//;

# If the name of the data file ends in a .txt or .dat extension, then 
# remove the extension.


# file with the list of edges in each cut
$cut_file = $file_name . ".cuts.txt";

# file with the flow and demands separated by each cut
$flow_file = $file_name . ".flows.txt";

# file with the flow and demands separated by each cut
$csv_file = $file_name . ".csv";

# file with the flow and demands separated by each cut
$flow_through_file = $file_name . ".flow_through.txt";

# file with LP formulation
$lp_file = $file_name . ".lp.txt";

# file with node partitions
$partition_file = $file_name . ".partitions.txt";

$dual_file = $file_name . ".dual.txt";

$cc_file = $file_name . ".cc.txt";

printf "solving $data_file\n";

open(AMPL,"|ampl") or die('ampl is not installed!');;
select(AMPL);
printf "param cut_file symbolic := \'$cut_file\';\n";
printf "param flow_file symbolic := \'$flow_file\';\n";
printf "param csv_file symbolic := \'$csv_file\';\n";
printf "param flow_through_file symbolic := \'$flow_through_file\';\n";
printf "param lp_file symbolic := \'$lp_file\';\n";
printf "param partition_file symbolic := \'$partition_file\';\n";
printf "param dual_file symbolic := \'$dual_file\';\n";
printf "param cc_file symbolic := \'$cc_file\';\n";
printf "model hmcfp_t_model.txt;\n";
printf "data $ARGV[0];\n"; 

if ($argc > 1) {
    printf "param max_levels default $ARGV[1];\n";
} else {
    printf "param max_levels default n*(n-1)/2;\n";
}

print "printf \"%s\\n\",ctime();\n";
print "printf \"Problem: HMCFP\\n\";\n";
print "printf \"Formulation: triples\\n\";\n";
print "printf \"Data file: $ARGV[0]\\n\";\n";
print "include hmcfp_t_script.txt;\n";
close(AMPL);

select(STDOUT);
printf "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n";
printf "\nExecution complete.\n";
# rename and set permissions for the various output files
printf "Cut edges written to $cut_file\n";
#system("chmod g+rwx $cut_file");
printf "Flow and component data written to $flow_file\n";
#system("chmod g+rwx $flow_file");
printf "Peer-to-peer flows written to $csv_file\n";
#system("chmod g+rwx $csv_file");
printf "Flow-through centrality written to $flow_through_file\n";
#system("chmod g+rwx $flow_through_file");
printf "Partition hierarchy written to $partition_file\n";
