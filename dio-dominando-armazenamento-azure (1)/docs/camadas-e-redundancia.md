# Camadas e Redundância

## Camadas

| Camada | Perfil |
|---|---|
| Hot | acesso frequente |
| Cool | acesso menos frequente |
| Cold | acesso pouco frequente |
| Archive | retenção longa e acesso raro |

A camada deve ser escolhida considerando frequência de acesso, retenção e custo de armazenamento/operações.

## Redundância

| Opção | Conceito |
|---|---|
| LRS | cópias na região primária |
| ZRS | redundância entre zonas da região |
| GRS | replicação geográfica |
| RA-GRS | GRS com leitura secundária |
| GZRS | zona + geografia |
| RA-GZRS | GZRS com leitura secundária |

A disponibilidade dessas opções varia por região e tipo de conta.
