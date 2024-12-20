# Custom-colors CONIPHER

## CONIPHER mutation clustering and phylogenetic tree building R package
This is a fork of the official CONIPHER repository that can be found at [https://github.com/McGranahanLab/CONIPHER](https://github.com/McGranahanLab/CONIPHER).

In this version, one has the ability to define custom cluster colors in the initial function call. This is usefull if you require other plots in your project than the ones CONIPHER produces and you wish to unify the colors for easier comparison.

In addition, it is possible to limit the number of plotted alternative trees: This number may grow into the thousands in cases where many clones are found resulting in a very large and likely unusable pdf output. Limiting this number allows the user to at least get at quick overview of the first alternative trees in the set of alternative trees.

### Software
The current implementation of CONIPHER is written in `R>=3.6.1` and is distributed as an R package.

---
## Installation 


The easiest way to ensure installation of all dependencies is to install the original CONIPHER via Conda into a separate environment. Assuming you have mamba installed, run the command:
```
mamba create -n ccconipher -c conda-forge -c bioconda conipher=2.2.0
```
Next, activate the created environment and start R by typing R and pressing enter. Then, remove the original CONIPHER package and install the one from this repo:
```
remove.packages("CONIPHER")
library(devtools)
devtools::install_github("stefmldk/CCCONIPHER")
```
Skip updates by pressing enter when prompted.
Exit out of R by running q() and choose n when asked to save the workspace image.

The environment is now ready to run CCCONIPHER with custom colors.

---
## Quick start

### Running clustering + tree building end-to-end 

The edited files in this repo requires CONIPHER to be run via the run_conipher.R script found in the tools folder. Place the script in a folder of your choice and call it like this:
```
Rscript folder_of_your_choice/run_conipher.R \
        --case_id the_case_id \
        --prefix a_prefix \
        --out_dir output_folder \
        --input_tsv_loc conipher_input_tsv \
        --nProcs number_of_threads \
        --custom_colors "#1f78b4,#b2df8a,#33a02c,#fb9a99,#e31a1c" \
        --max_alt_trees 9
```
If the custom_colors and/or max_alt_trees arguments are left out, the output should correspond to the forked CONIPHER. Note: Colors must be provided as hexadecimal. Due to '#' having a special meaning in bash, the colors list must be in quotes.

Please format the input tsv as in the example below where copy numbers A and B correspond to major and minor and only include autosomes with a number (ommit 'chr' prefix in chromosome names and exclude X, Y, M plus unassembled contigs):
```
CASE_ID	SAMPLE	CHR	POS	REF	ALT	REF_COUNT	VAR_COUNT	DEPTH	COPY_NUMBER_A	COPY_NUMBER_B	ACF	PLOIDY
G74E	G74E_4	1	9737534	C	A	27	0	27	2	0	0.57	3.8
G74E	G74E_5	1	9737534	C	A	32	0	32	3	0	0.52	3.9
G74E	G74E_6	1	9737534	C	A	24	0	24	2	0	0.56	3.8
G74E	G74E_4	1	11531040	G	T	59	0	59	2	0	0.57	3.8
G74E	G74E_5	1	11531040	G	T	79	0	79	3	0	0.52	3.9
G74E	G74E_6	1	11531040	G	T	47	0	47	2	0	0.56	3.8
```

---
### Anticipated results
The clustering output will include the following output files (examples are in "conipher_results/Clustering"):
- <CASE_ID>_pyclone_cluster_assignment_ccf_clean.pdf
- <CASE_ID>_pyclone_cluster_assignment_copynumber_clean.pdf
- <CASE_ID>_pyclone_cluster_assignment_mutCpn_clean.pdf

The tree building output will include 3 output files (examples are in "conipher_results/Trees"):
- <CASE_ID>.tree.RDS: an R list object containing tree building output information
- pytree_and_bar.pdf: a plot of the default reconstructed tree and barplot
- pytree_multipletrees.pdf: a plot showing all possible alternative phylogenetic trees found by CONIPHER



