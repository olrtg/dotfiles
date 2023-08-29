return {
  s("experror", { c(1, {
    t("// @ts-expect-error "),
    t("{/* @ts-expect-error */}"),
  }) }),
}
