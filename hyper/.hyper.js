// ----------------------------------------------
//   Author: Liam Howell
//   Description: Configuration options for Hyper goodness
//
//   Future versions of Hyper may add additional config options,
//   which will not automatically be merged into this file.
//   See https://hyper.is#cfg for all currently supported options.
// ----------------------------------------------

// translucify a hex value
const translucify = (hex, opacity = 1) => {
  return `${hex}${Math.floor(opacity * 255).toString(16)}`;
}

// color palette - taken to match current vscode theme
const colors = {
  black: '#292D3F',
  blue: '#81AAFF',
  cyan: '#93D8EC',
  green: '#B5E085',
  grey: '#697098',
  magenta: '#C896E9',
  red: '#EC6575',
  white: '#D7DEE6',
  yellow: '#F5CF89',
};

module.exports = {
  config: {
    // choose either `'stable'` for receiving highly polished,
    // or `'canary'` for less polished but more frequent updates
    updateChannel: 'stable',

    // default width/height in pixels of a new window
    windowSize: [
      900,
      540
    ],

    // default font size in pixels for all tabs
    fontSize: 13,

    // font family with optional fallbacks
    fontFamily: 'MesloLGM Nerd Font, Menlo, Consolas, DejaVu Sans Mono, monospace',

    // default font weight: 'normal' or 'bold'
    fontWeight: 'normal',

    // font weight for bold characters: 'normal' or 'bold'
    fontWeightBold: 'bold',

    // line height as a relative unit
    lineHeight: 1.5,

    // letter spacing as a relative unit
    letterSpacing: 0.5,

    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: 'BLOCK',

    // set to `true` (without backticks and without quotes) for blinking cursor
    cursorBlink: false,

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: colors.white,

    // terminal text color under BLOCK cursor
    cursorAccentColor: colors.white,

    // color of the text
    foregroundColor: colors.white,

    // terminal background color
    // opacity is only supported on macOS
    backgroundColor: colors.black,

    // terminal selection color
    selectionColor: colors.white,

    // border color (window, tabs)
    borderColor: colors.black,

    // custom CSS to embed in the main window
    css: `
      .tabs_nav,
      .tab_tab:not(.tab_active),
      .tab_tab:not(.tab_active):hover {
        background-color: #212433;
        color: ${translucify(colors.white, 0.4)};
      }

      .tab_tab:not(.tab_active) .tab_process::before,
      .tab_tab:not(.tab_active):hover .tab_process::before {
        background-color: ${translucify(colors.white, 0.4)};
        opacity: 1;
      }

      .tab_tab.tab_active,
      .tabs_title {
        background-color: ${colors.black} !important;
      }

      .tabs_title {
        font-size: 0;
      }

      .tabs_title .tab_process::before {
        visibility: hidden;
      }
    `,

    // custom CSS to embed in the terminal window
    termCSS: '',

    // set custom startup directory (must be an absolute path)
    workingDirectory: '',

    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: '',

    // set to `false` (without backticks and without quotes) if you want to hide the minimize,
    // maximize and close buttons additionally, set to `'left'` if you want them on the left,
    // like in Ubuntu
    // default: `true` (without backticks and without quotes) on Windows and Linux,
    // ignored on macOS
    showWindowControls: '',

    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: '20px 14px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black: colors.grey,
      lightBlack: colors.grey,
      blue: colors.blue,
      lightBlue: colors.blue,
      cyan: colors.cyan,
      lightCyan: colors.cyan,
      green: colors.green,
      lightGreen: colors.green,
      magenta: colors.magenta,
      lightMagenta: colors.magenta,
      red: colors.red,
      lightRed: colors.red,
      yellow: colors.yellow,
      lightYellow: colors.yellow,
      white: colors.white,
      lightWhite: colors.white,
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    shell: '/opt/homebrew/bin/zsh',

    // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
    // by default `['--login']` will be used
    shellArgs: [
      '--login',
    ],

    // for environment variables
    env: {},

    // set to `false` for no bell
    bell: false,

    // if `true` (without backticks and without quotes), selected text will automatically be
    // copied to the clipboard
    copyOnSelect: false,

    // if `true` (without backticks and without quotes), hyper will be set as the default protocol
    // client for SSH
    defaultSSHApp: true,

    // if `true` (without backticks and without quotes), on right click selected text will be
    // copied or pasted if no selection is present (`true` by default on Windows and disables the
    // context menu feature)
    quickEdit: false,

    // choose either `'vertical'`, if you want the column mode when Option key is hold during
    // selection (Default) or `'force'`, if you want to force selection regardless of whether the
    // terminal is in mouse events mode (inside tmux or vim with mouse mode enabled for example).
    macOptionSelectionMode: 'vertical',

    // whether to use the WebGL renderer. Set it to false to use canvas-based
    // rendering (slower, but supports transparent backgrounds)
    webGLRenderer: true,

    // keypress required for weblink activation: [ctrl|alt|meta|shift]
    // todo: does not pick up config changes automatically, need to restart terminal :/
    webLinksActivationKey: '',

    // if `false` (without backticks and without quotes), Hyper will use ligatures provided
    // by some fonts
    disableLigatures: true,

    // hyper unlimited power plugin configuration options
    hyperUnlimitedPower: {
      isComboEnabled: false,
      isRainbowEnabled: false,
      staticParticleColors: [
        colors.yellow
      ]
    },
  },

  // a list of plugins to fetch and install from npm
  plugins: [
    'hyper-unlimited-power'
  ],
};
