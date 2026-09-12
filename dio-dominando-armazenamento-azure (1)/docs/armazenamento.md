# Fundamentos de Armazenamento

Uma Storage Account fornece um namespace para dados do Azure Storage e pode hospedar blobs, arquivos, filas e tabelas.

## Escolha utilizada

- Tipo: StorageV2 / General Purpose v2
- Performance: Standard
- Redundância: LRS
- TLS mínimo: 1.2
- Blob público: desabilitado

## Blob Storage

O Blob Storage é apropriado para objetos não estruturados, como documentos, imagens, backups, logs e arquivos de aplicação.

Estrutura utilizada:

```text
Storage Account
└── laboratorio
    └── evidencias/
        └── lab.txt
```
