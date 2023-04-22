;; extends
(
  (string_fragment) @injection.content (#match? @injection.content "^query|mutation")
  (#set! injection.language "graphql")
)
