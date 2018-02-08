import buble from 'rollup-plugin-buble';

export default {
  input: 'src/main.js',
  output: {
    file: 'www/bundle.js',
    format: 'cjs'
  },
  plugins: [buble()]
};
