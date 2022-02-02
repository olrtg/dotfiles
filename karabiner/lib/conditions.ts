// deno-lint-ignore-file camelcase
import { Condition } from 'https://raw.githubusercontent.com/esamattis/deno_karabiner/master/lib/karabiner.ts'

export const nonAppleDevice: Condition = {
  type: 'device_unless',
  identifiers: [
    {
      vendor_id: 1452,
    },
  ],
}
