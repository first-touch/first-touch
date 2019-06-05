<template>
  <div class="dropdown">
    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      {{ currentLang }}
    </button>
    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
      <a class="dropdown-item" v-for="lang in languages" :key="lang" @click="changeLang(lang)"> {{ lang }} </a>
    </div>
  </div>
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

      import(/* webpackChunkName: "lang-[request]" */ `lang/${lang}.json`).then((msgs) => {
        this.$i18n.setLocaleMessage(lang, msgs.default || msgs);
        this.$i18n.locale = lang;
      });
    }
  },
  computed: {
    currentLang() {
      return this.$i18n.locale;
    }
  }
}
</script>
