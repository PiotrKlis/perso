# perso

Personalized training plans

## Getting Started

## Assets code generation

We are using [spider](https://pub.dev/packages/spider) for assets code generation. After adding new
assets to [Images directory](assets/images) or [Vectors directory](assets/vectors) you should
run [spider](https://pub.dev/packages/spider):

- `spider build`

This command will generate .dart files in [Values directory](lib/src/ui/styleguide/values) and unit
tests in [Test directory](test).