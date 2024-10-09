#' Full CONIPHER run
#'
#' This function takes all the input options and runs the three main steps:
#' preprocess, tree building run and postprocess
#' @param opt a list of options
#' @returns NULL
#' @export conipher_run

conipher_run <- function(case_id, prefix, out_dir, input_tsv_loc, custom_colors, max_alt_trees, ...) {
    out_dir_tmp <- paste0(out_dir, "/Clustering/")

    if (length(custom_colors)) {
        cat('\nRunning CONIPHER with custom colors...\n')
    }

    # Make custom_colors and max_alt_trees globally available since they are referenced in some other modules that will not get them via function params
    assign("custom_colors", custom_colors, envir = .GlobalEnv)
    assign("max_alt_trees", max_alt_trees, envir = .GlobalEnv)

    conipher_clustering(case_id = case_id,
                        out_dir = out_dir_tmp,
                        input_tsv_loc = input_tsv_loc,
                        ...)
    tree_input_tsv_loc <- paste0(out_dir_tmp, case_id, ".SCoutput.CLEAN.tsv")
    out_dir_tmp <- paste0(out_dir, "/Trees/")
    conipher_treebuilding(input_tsv_loc = tree_input_tsv_loc,
                          out_dir = out_dir_tmp,
                          prefix = prefix,
                          ...)
}
