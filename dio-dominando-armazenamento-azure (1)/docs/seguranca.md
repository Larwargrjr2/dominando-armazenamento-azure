# Segurança

## Controles aplicados no laboratório

- TLS mínimo 1.2.
- Acesso público a Blob desabilitado.
- Container privado.
- Autenticação via Azure CLI com `--auth-mode login`.
- Nenhuma chave de Storage Account armazenada no repositório.

## Boas práticas para produção

- Microsoft Entra ID + RBAC.
- Princípio do menor privilégio.
- Private Endpoint quando apropriado.
- Restrições de rede.
- Monitoramento e alertas.
- Políticas de ciclo de vida.
- Proteção contra exclusão acidental conforme o requisito.
