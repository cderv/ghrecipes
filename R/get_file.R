#' Get contents of a file
#'
#' @param owner
#' @param repo
#' @param branch
#' @param path
#'
#' @return
#' @export
#'
#' @details
#' https://platform.github.community/t/query-repo-contents-with-graphql-api/1896
#' @examples
#' library("magrittr")
#' pof <- get_file(owner = "ropensci", repo = "roregistry",
#'          branch = "master", path = "registry.json") %>%
#'          jsonlite::toJSON()
get_file <- function(owner, repo, branch, path){
  query <- paste0('query {
  repository(name: "', repo,'", owner: "', owner,'") {
                  object(expression: "', branch, ':', path, '") {
                  ... on Blob {
                  text
                  }
                  }
}
}')

  qry <- ghql::Query$new()
  qry$query('foobar', query)



  res <- cli$exec(qry$queries$foobar)
  res %>%
    jqr::jq(".data.repository.object.text")
}