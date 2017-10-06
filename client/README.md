# first-touch client app

This is a short write-up for anyone to get up and running for development of
firsttouch's frontend application

### Stuffs to have a look at before beginning

**Note**: If you have prior experience with React/Redux, understanding Vue/Vuex
should not be a big problem as the follow the same pattern

* [Vuejs API](https://vuejs.org/v2/api)
* [Vuex Docs](https://vuex.vuejs.org/en/)
* [Vue Router](https://router.vuejs.org/en/)

### Notes

This file structure was adapted from a design in React/Redux which
was drawn from [this](https://egghead.io/courses/build-a-react-app-with-redux) and
[this](https://learnredux.com/) courses. Feel free to have a look

##### Difference between components and containers

They are both folders of React components. However, one main difference is that
while a "container"is assumed to be allowed to read shared props and actions from
the vuex tree (i.e. store), a "component" is assumed to be "pure" (most of the
time), meaning it would only take it props passed during usage and are not
supposed to be "connected" to the store.

##### Why use folder for some of the components/containers?

My intentions is to have a sub-folder "components" that contains
all the componets that is useful to (i.e. is only used in) such
component/container.

##### Why sub folder of "components"?

These components are meant to be used only in the respective mother
container/component. Any shared components will be put inside "app/components"
folder.

##### How to pull in assets (images, stylesheets, etc) to use inside vue code?

* folder `src/images` is aliased as `~images`
* folder `src/stylesheets` is aliased as `~stylesheets`

### Burning question

Please contact me on
[Telegram](https://web.telegram.org/#/im?p=@stanley_nguyen) or
[Whatsapp](https://api.whatsapp.com/send?phone=6581489408) or
[Email](mailto:hung.ngn.the@gmail.com)
