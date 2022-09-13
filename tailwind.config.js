const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: ['./src/**/*.{njk,md}'],
  plugins: [require('daisyui'), require('@tailwindcss/typography')],
  theme: {
    screens: {
      'xs': '475px',
      ...defaultTheme.screens,
    },
  },
  daisyui: {
    themes: ['winter', 'night'],
    darkTheme: 'night',
  },
};