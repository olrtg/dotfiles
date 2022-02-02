import { KarabinerComplexModifications } from 'https://raw.githubusercontent.com/esamattis/deno_karabiner/master/lib/karabiner.ts'
import { hyper, hyperCmd } from './lib/hyper.ts'
import { remap } from './lib/remap.ts'

const mods = new KarabinerComplexModifications()

mods.addRule({
  description: 'Hyper Key',
  manipulators: [
    {
      from: { key_code: 'caps_lock', modifiers: { optional: ['any'] } },
      to: [{ key_code: 'left_shift', modifiers: ['left_control', 'left_option'] }],
      to_if_alone: [{ key_code: 'escape' }],
      type: 'basic',
    },
  ],
})

mods.addRule({
  description: 'Swap Command and Option on non-Apple keyboards',
  manipulators: [
    remap({ key_code: 'left_command' }, { key_code: 'left_option' }),
    remap({ key_code: 'left_option' }, { key_code: 'left_command' }),
  ],
})

mods.addRule({
  description: 'Hyper/Hyper+Cmd Directional Bindings',
  manipulators: [
    // Arrows
    hyper('h', 'left_arrow'),
    hyper('j', 'down_arrow'),
    hyper('k', 'up_arrow'),
    hyper('l', 'right_arrow'),

    // Arrows + Shift
    hyperCmd('h', 'left_arrow', { modifiers: ['left_shift'] }),
    hyperCmd('j', 'down_arrow', { modifiers: ['left_shift'] }),
    hyperCmd('k', 'up_arrow', { modifiers: ['left_shift'] }),
    hyperCmd('l', 'right_arrow', { modifiers: ['left_shift'] }),

    // Home/End
    hyper('n', 'left_arrow', { modifiers: ['left_command'] }),
    hyper('p', 'right_arrow', { modifiers: ['left_command'] }),

    // Left/Right one word
    hyper('m', 'left_arrow', { modifiers: ['left_option'] }),
    hyper('period', 'right_arrow', { modifiers: ['left_option'] }),

    // Home/End + Shift
    hyperCmd('n', 'left_arrow', { modifiers: ['left_shift', 'left_command'] }),
    hyperCmd('p', 'right_arrow', { modifiers: ['left_shift', 'left_command'] }),

    // Left/Right one word + Shift
    hyperCmd('m', 'left_arrow', { modifiers: ['left_shift', 'left_option'] }),
    hyperCmd('period', 'right_arrow', { modifiers: ['left_shift', 'left_option'] }),

    // Page Up/Down
    hyper('u', 'page_down'),
    hyper('i', 'page_up'),

    // Start/End of page
    hyperCmd('u', 'down_arrow', { modifiers: ['left_command'] }),
    hyperCmd('i', 'up_arrow', { modifiers: ['left_command'] }),
  ],
})

mods.writeToProfile('Default profile')
