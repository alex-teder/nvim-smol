; extends

; sql<T>`...`
(call_expression
  function: (non_null_expression
    (instantiation_expression
      (identifier) @_name
      (#eq? @_name "sql")
      type_arguments: (type_arguments)))
  arguments: ((template_string) @injection.content
    (#offset! @injection.content 0 1 0 -1)
    (#set! injection.include-children)
    (#set! injection.language "sql")))

; yield* sql<T>`...`
(call_expression
  function: (non_null_expression
    (yield_expression
      (instantiation_expression
        (identifier) @_name
        (#eq? @_name "sql")
        type_arguments: (type_arguments))))
  arguments: ((template_string) @injection.content
    (#offset! @injection.content 0 1 0 -1)
    (#set! injection.include-children)
    (#set! injection.language "sql")))

; The TypeScript grammar parses simple type arguments such as sql<any> as comparisons.
(binary_expression
  left: (binary_expression
    left: (identifier) @_name
    (#eq? @_name "sql"))
  right: (template_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "sql"))
