// ----------------------------------------------
//   Author: Liam Howell
//   Description: Configuration options for Hyper goodness
//
//   Future versions of Hyper may add additional config options,
//   which will not automatically be merged into this file.
//   See https://hyper.is#cfg for all currently supported options.
// ----------------------------------------------

// color palette - taken to match current vscode theme
const colors = {
  black: '#292D3F',
  blue: '#81AAFF',
  cyan: '#93D8EC',
  green: '#B5E085',
  grey: '#697098',
  magenta: '#C896E9',
  red: '#EC6575',
  white: '#C7CBE0',
  yellow: '#F5CF89',
};

// config options for the terminal
const config = {
  // terminal background color
  // opacity is only supported on macOS
  backgroundColor: colors.black,

  // set to `false` for no bell
  bell: false,

  // border color (window, tabs)
  borderColor: colors.black,

  // the full list. if you're going to provide the full color palette,
  // including the 6 x 6 color cubes and the grayscale map, just provide
  // an array here instead of a color map object
  colors: {
    black: colors.grey,
    blue: colors.blue,
    cyan: colors.cyan,
    green: colors.green,
    lightBlack: colors.grey,
    lightBlue: colors.blue,
    lightCyan: colors.cyan,
    lightGreen: colors.green,
    lightMagenta: colors.magenta,
    lightRed: colors.red,
    lightWhite: colors.white,
    lightYellow: colors.yellow,
    magenta: colors.magenta,
    red: colors.red,
    white: colors.white,
    yellow: colors.yellow,
  },

  // if `true` (without backticks and without quotes), selected text will automatically be
  // copied to the clipboard
  copyOnSelect: false,

  // terminal text color under BLOCK cursor
  cursorAccentColor: colors.white,

  // set to `true` (without backticks and without quotes) for blinking cursor
  cursorBlink: false,

  // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
  cursorColor: colors.white,

  // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
  cursorShape: 'BLOCK',

  // if `true` (without backticks and without quotes), hyper will be set as the default protocol
  // client for SSH
  defaultSSHApp: true,

  // if `false` (without backticks and without quotes), Hyper will use ligatures provided
  // by some fonts
  disableLigatures: true,

  // for environment variables
  env: {},

  // color of the text
  foregroundColor: colors.white,

  // font family with optional fallbacks
  fontFamily: 'JetBrainsMono NF',

  // default font size in pixels for all tabs
  fontSize: 14,

  // default font weight: 'normal' or 'bold'
  fontWeight: 'normal',

  // font weight for bold characters: 'normal' or 'bold'
  fontWeightBold: 'bold',

  // hyper unlimited power plugin configuration options
  hyperUnlimitedPower: {
    isComboEnabled: false,
    isRainbowEnabled: false,
    staticParticleColors: [colors.yellow]
  },

  // letter spacing as a relative unit
  letterSpacing: 0,

  // line height as a relative unit
  lineHeight: 1,

  // choose either `'vertical'`, if you want the column mode when Option key is hold during
  // selection (Default) or `'force'`, if you want to force selection regardless of whether the
  // terminal is in mouse events mode (inside tmux or vim with mouse mode enabled for example).
  macOptionSelectionMode: 'vertical',

  // keybindings for the terminal
  modifierKeys: {
    altIsMeta: true,
  },

  // custom padding (CSS format, i.e.: `top right bottom left`)
  padding: '0 8px 10px 17.5px',

  // if `true` (without backticks and without quotes), on right click selected text will be
  // copied or pasted if no selection is present (`true` by default on Windows and disables the
  // context menu feature)
  quickEdit: false,

  // the number of rows to be persisted in terminal buffer for scrolling
  scrollback: 400,

  // terminal selection color
  selectionColor: colors.white,

  // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
  // if left empty, your system's login shell will be used by default
  shell: '/opt/homebrew/bin/zsh',

  // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
  // by default `['--login']` will be used
  shellArgs: ['--login'],

  // if you're using a Linux setup which show native menus, set to false
  // default: `true` on Linux, `true` on Windows, ignored on macOS
  showHamburgerMenu: '',

  // set to `false` (without backticks and without quotes) if you want to hide the minimize,
  // maximize and close buttons additionally, set to `'left'` if you want them on the left,
  // like in Ubuntu
  // default: `true` (without backticks and without quotes) on Windows and Linux,
  // ignored on macOS
  showWindowControls: '',

  // custom CSS to embed in the terminal window
  termCSS: '',

  // choose either `'stable'` for receiving highly polished,
  // or `'canary'` for less polished but more frequent updates
  updateChannel: 'stable',

  // whether to use the WebGL renderer. Set it to false to use canvas-based
  // rendering (slower, but supports transparent backgrounds)
  webGLRenderer: true,

  // keypress required for weblink activation: [ctrl|alt|meta|shift]
  // todo: does not pick up config changes automatically, need to restart terminal :/
  webLinksActivationKey: '',

  // default width/height in pixels of a new window
  windowSize: [1350, 800],

  // set custom startup directory (must be an absolute path)
  workingDirectory: '',
};

// keymaps to customize the terminal
const keymaps = {
  'pane:close': 'shift+ctrl+alt+command+1',
  'pane:next': 'shift+ctrl+alt+command+2',
  'pane:prev': 'shift+ctrl+alt+command+3',
  'pane:splitDown': 'shift+ctrl+alt+command+4',
  'pane:splitRight': 'shift+ctrl+alt+command+5',
  'tab:jump:prefix': 'shift+ctrl+alt+command+6',
  'tab:new': 'shift+ctrl+alt+command+7',
  'tab:next': 'shift+ctrl+alt+command+8',
  'tab:prev': 'shift+ctrl+alt+command+9',
};

// a list of plugins to fetch and install from npm
const plugins = [
  'hyper-unlimited-power'
];

module.exports = Object.assign({}, { config, keymaps, plugins });
