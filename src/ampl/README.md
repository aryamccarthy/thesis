# HMCFP Solver

Compute the leximin-maximal concurrent flow in a network of given capacities and demands.

## Usage

To compute for the data file `network.dat`, use the following command:

```bash
perl solve_hmcfp_t.pl network.dat
```

If only the first, say, 6 levels are wanted, use:

```bash
perl solve_hmcfp_t.pl network.dat 6
```


## Input format

A typical input file looks like:

```ampl
# Comments begin with the pound sign (#)
# `n` is the number of nodes in the network.
param n := 3;
# E gives the edges as pairs of nodes.
# It is 1-indexed.
set E := (1, 2) (1, 3)
(2, 3)
;
```

Capacities can be given on the edges by specifying the parameter `C` as below.

```ampl
param n := 3;
set E := (1, 2) (1, 3)
(2, 3)
;
param C := 
1 2 3
1 3 4
2 3 5
; 
```

Demand can be similarly specified between a pair using the parameter `D`.

## Output files

- `network.csv` gives the lexicographic maximum concurrent flow between each pair.
- `network.cuts.txt` lists the edges that are cut at each level.
- `network.flow_through.txt` gives the flowthrough centrality of each node.
- `network.flows.txt` gives the diversion of flow according to the triples formulation.
- `network.lp.txt` contains a literate expression of the linear program which AMPL solves.
- `network.partitions.txt` gives the sequence of cuts, their corresponding throughput values, and the relations between the communities that are formed.
