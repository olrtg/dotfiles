;; extends
(
  (string_content) @injection.content (#match? @injection.content ";; query")
  (#set! injection.language "query")
)

