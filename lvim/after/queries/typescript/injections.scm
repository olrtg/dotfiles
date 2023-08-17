;; extends
(
  [(string_fragment) (template_string)] @injection.content (#match? @injection.content "^query|mutation|`query|`mutation")
  (#set! injection.language "graphql")
)
