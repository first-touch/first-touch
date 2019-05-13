<template>
  <ul>
    <li v-for="lang in languages" :key="lang" @click="changeLang(lang)"> {{ lang }} </li>
  </ul>
</template>

<script>
export default {
  name: 'LanguageSwitcher',
  data: () => ({
    languages: ['en', 'pt']
  }),
  methods: {
    changeLang (lang) {
      if (!this.languages.includes(lang)) lang = 'en';
      if (lang == this.$i18n.locale) return;

      import('@/lang/${lang}.json').then((msgs) => {
        this.$i18n.setLocaleMessage(lang, msgs.default || msgs);
        this.$i18n.locale = lang;
      });
    }
  }
}
</script>
