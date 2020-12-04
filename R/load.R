get_datasets <- function(datasets_files) {

    `%>%` <- magrittr::`%>%`

    datasets_list <- purrr::map(dataset_files, function (.file) {
        readr::read_csv(
            .file,
            col_types = readr::cols(
                .default      = readr::col_character(),
                X1            = readr::col_double(),
                ncells        = readr::col_double(),
                year          = readr::col_double(),
                has_celltypes = readr::col_logical()
            )
        )
    })

    datasets <- datasets_list %>%
        dplyr::bind_rows() %>%
        dplyr::mutate(
            study = stringr::str_extract(id, "(?<=_)[^_]*$")
        ) %>%
        dplyr::mutate(
            animal    = factor(animal),
            organ     = factor(organ),
            subtissue = factor(subtissue),
            protocol  = factor(protocol)
        ) %>%
        dplyr::select(-X1) %>%
        dplyr::relocate(
            id, animal, organ, subtissue, ncells, protocol, counts,
            has_celltypes, study, lab, year
        )
}
