;; extends

;; For GraphQL queries inside strings in Poverty Stoplight
(
  [(string_fragment) (template_string)] @injection.content (#match? @injection.content "^query|mutation|`query|`mutation")
  (#set! injection.language "graphql")
)
