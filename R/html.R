value_box <- function(value, caption = NULL, icon = NULL,
                      colour = c("primary", "info", "success", "warning", "danger")) {

    tags <- htmltools::tags

    colour <- match.arg(colour)
    colour <- paste0("bg-", colour)

    content <- list(
        tags$p(class = "value", value)
    )

    if (!is.null(caption)) {
        content <- c(
            content,
            list(
                tags$p(class = "caption", caption)
            )
        )
    }

    box_content <- list(
        tags$div(
            class = "inner",
            content
        )
    )

    if (!is.null(icon)) {
        box_content <- c(
            box_content,
            list(
                tags$div(
                    class = "icon",
                    tags$i(
                        class = paste0("fa fa-", icon)
                    )
                )
            )
        )
    }

    tags$div(
        class = paste("value-box", colour),
        box_content
    )
}
