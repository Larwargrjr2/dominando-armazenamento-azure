# ☁️ Dominando o Armazenamento no Azure

![Azure](https://img.shields.io/badge/Microsoft%20Azure-0089D6?style=for-the-badge&logo=microsoftazure&logoColor=white)
![AZ-900](https://img.shields.io/badge/AZ--900-Cloud%20Fundamentals-0078D4?style=for-the-badge)
![Azure CLI](https://img.shields.io/badge/Azure%20CLI-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)

> Projeto prático desenvolvido durante a formação **Microsoft Azure – AZ-900 Certification**, da DIO, com foco em armazenamento em nuvem, Blob Storage, segurança, redundância, camadas de acesso e automação com Azure CLI.

## 📌 Sobre o projeto

Este laboratório amplia o desafio da DIO com uma implementação prática e reproduzível de **Azure Storage Account + Blob Storage**.

O projeto permite criar, testar e remover os recursos utilizando scripts Azure CLI, sem incluir credenciais ou evidências fictícias.

## 🎯 Objetivos

- Criar uma Storage Account **StorageV2 / GPv2 Standard**.
- Criar um container privado de Blob Storage.
- Realizar upload, listagem e download de arquivos.
- Validar o funcionamento automaticamente.
- Compreender camadas de acesso e redundância.
- Aplicar conceitos básicos de segurança.
- Automatizar implantação e limpeza.
- Controlar custos removendo os recursos após o laboratório.

## 🏗️ Arquitetura

```text
                         ☁️ MICROSOFT AZURE
                                │
                                ▼
                    ┌─────────────────────┐
                    │    Resource Group   │
                    │   rg-storage-az900  │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   Storage Account   │
                    │ StorageV2 / Standard │
                    │        LRS           │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   Blob Container    │
                    │     laboratorio     │
                    │       privado       │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │    Blob / Objeto    │
                    │ evidencias/lab.txt  │
                    └─────────────────────┘
```

![Arquitetura Azure Storage](images/arquitetura-armazenamento.svg)

## ☁️ Azure Storage

O Azure Storage oferece serviços para diferentes tipos de dados:

| Serviço | Utilização |
|---|---|
| Blob Storage | Objetos e dados não estruturados |
| Azure Files | Compartilhamentos de arquivos |
| Queue Storage | Mensagens assíncronas |
| Table Storage | Dados NoSQL estruturados |

Neste laboratório, o foco é o **Blob Storage**.

## 🗄️ Storage Account

| Configuração | Valor |
|---|---|
| Tipo | StorageV2 |
| Performance | Standard |
| Redundância | LRS |
| TLS mínimo | 1.2 |
| Blob público | Desabilitado |
| Container | `laboratorio` |

O nome da Storage Account é gerado automaticamente pelo `deploy.sh` para evitar conflitos de nomes.

## 📦 Blob Storage

O Blob Storage é apropriado para dados não estruturados, como documentos, imagens, backups, logs e arquivos de aplicações.

Estrutura utilizada:

```text
Storage Account
└── laboratorio
    └── evidencias/
        └── lab.txt
```

## 🔧 Pré-requisitos

- Assinatura Azure ativa.
- Azure CLI instalada.
- Conta autenticada.
- Bash, WSL ou Azure Cloud Shell.

Autentique:

```bash
az login
az account show
```

## 🚀 Deploy

Entre no projeto:

```bash
cd dominando-armazenamento-azure
chmod +x scripts/*.sh
./scripts/deploy.sh
```

O script cria:

1. Resource Group;
2. Storage Account;
3. configurações básicas de segurança;
4. container privado;
5. arquivo de teste;
6. Blob;
7. informações para validação.

## 🧪 Teste funcional

Depois do deploy:

```bash
./scripts/test.sh
```

O teste valida:

```text
[PASS] Resource Group encontrado
[PASS] Storage Account encontrada
[PASS] Container encontrado
[PASS] Blob baixado
[PASS] Conteúdo validado

Todos os testes passaram.
```

O resultado real depende da execução na sua assinatura Azure.

## 📤 Upload

Para enviar outro arquivo:

```bash
STORAGE_ACCOUNT=<nome-da-storage-account> ./scripts/upload-test.sh arquivo.txt
```

## 📋 Listagem

```bash
az storage blob list   --account-name <storage-account>   --container-name laboratorio   --auth-mode login   --output table
```

## 📥 Download

```bash
az storage blob download   --account-name <storage-account>   --container-name laboratorio   --name evidencias/lab.txt   --file ./download/lab.txt   --auth-mode login
```

## 🔐 Segurança

Controles utilizados no laboratório:

- TLS 1.2 como versão mínima;
- acesso público ao Blob desabilitado;
- container privado;
- autenticação pelo Azure CLI;
- nenhuma chave armazenada no código;
- `.gitignore` para arquivos temporários.

Para produção, avalie Microsoft Entra ID, RBAC, menor privilégio, Private Endpoint, restrições de rede, monitoramento e políticas de ciclo de vida.

## ♻️ Redundância

O laboratório utiliza:

```text
Standard_LRS
```

Principais opções do Azure Storage:

| Opção | Conceito |
|---|---|
| LRS | Redundância local |
| ZRS | Redundância entre zonas |
| GRS | Redundância geográfica |
| RA-GRS | GRS com leitura secundária |
| GZRS | Zonal + geográfica |
| RA-GZRS | GZRS com leitura secundária |

A escolha depende dos requisitos de disponibilidade, proteção e custo.

## 🗂️ Camadas de acesso

| Camada | Perfil |
|---|---|
| Hot | Acesso frequente |
| Cool | Acesso menos frequente |
| Cold | Acesso pouco frequente |
| Archive | Acesso raro e recuperação mais lenta |

A camada deve considerar frequência de acesso, retenção e custos.

## 💰 Custos

Os scripts criam recursos reais no Azure.

Após finalizar os testes:

```bash
./scripts/destroy.sh
```

O script solicita a confirmação:

```text
Digite DELETE para confirmar:
```

> Nunca deixe recursos de laboratório ativos sem necessidade.

## 🧹 Limpeza

```bash
./scripts/destroy.sh
```

A exclusão é realizada no Resource Group utilizado pelo laboratório.

> Confirme que o Resource Group é exclusivo deste projeto antes de executar a remoção.

## 📂 Estrutura

```text
dominando-armazenamento-azure/
├── README.md
├── .gitignore
├── docs/
│   ├── armazenamento.md
│   ├── camadas-e-redundancia.md
│   ├── seguranca.md
│   └── checklist.md
├── images/
│   └── arquitetura-armazenamento.svg
└── scripts/
    ├── deploy.sh
    ├── upload-test.sh
    ├── test.sh
    └── destroy.sh
```

## 📚 O que aprendi

Este laboratório consolidou conhecimentos sobre:

- Azure Storage;
- Storage Account;
- Blob Storage;
- containers;
- upload e download;
- autenticação e autorização;
- segurança;
- redundância;
- disponibilidade;
- camadas de acesso;
- Azure CLI;
- automação;
- controle de custos;
- ciclo de vida de recursos.

## 🧾 Checklist de evidências

Após executar o laboratório:

- [ ] Resource Group criado;
- [ ] Storage Account criada;
- [ ] Container privado criado;
- [ ] Blob enviado;
- [ ] Blob listado;
- [ ] Blob baixado;
- [ ] Conteúdo validado;
- [ ] Testes concluídos;
- [ ] Recursos removidos.

> Screenshots e URLs de recursos reais devem ser adicionados somente após a execução na própria assinatura Azure.

## 🔗 Links oficiais e de teste

### Microsoft Learn

- Azure Storage:
  https://learn.microsoft.com/pt-br/azure/storage/common/storage-account-overview
- Criar Storage Account:
  https://learn.microsoft.com/pt-br/azure/storage/common/storage-account-create
- Blob Storage:
  https://learn.microsoft.com/pt-br/azure/storage/blobs/storage-blobs-introduction
- Camadas de acesso:
  https://learn.microsoft.com/pt-br/azure/storage/blobs/access-tiers-overview
- Redundância:
  https://learn.microsoft.com/pt-br/azure/storage/common/storage-redundancy
- Azure CLI — Blob:
  https://learn.microsoft.com/pt-br/cli/azure/storage/blob

### DIO

- Formação Microsoft Azure AZ-900:
  https://web.dio.me/track/formacao-microsoft-az-900-certification
- Laboratório de Armazenamento:
  https://web.dio.me/lab/armazenamento-laboratorio-1/learning/e4e71071-3958-4a62-ad64-42f1d4720997

## ⚠️ Evidências reais

Este projeto fornece automação reproduzível, mas os recursos Azure precisam ser executados na sua própria assinatura.

Não são utilizados screenshots, URLs de recursos ou resultados de testes fictícios.

## 🎓 Formação

**Microsoft Azure – AZ-900 Certification**

Projeto desenvolvido como parte dos desafios práticos da **DIO**.

## 👨‍💻 Autor

**Larwargrjr**

---

⭐ Se este projeto ajudou nos seus estudos de Azure, considere deixar uma estrela no repositório!
