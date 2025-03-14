module.exports = {
    extends: [
        'eslint:recommended',
        'plugin:vue/vue3-recommended',
        '@vue/eslint-config-prettier'
    ],
    plugins: ['prettier'],
    rules: {
        'prettier/prettier': 'error'
    }
};
  