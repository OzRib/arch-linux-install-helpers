# arch-linux-install-helpers
Uma série de scripts para facilitar a instalação do arch linux.
O objetivo é trazer de forma rápida e simples uma instalação básica do Arch.

## Como usar?
Para usar qualquer um desses arquivos basta indicar o caminho do diretório até ele.
Exemplo:
```
install-files/system-install.sh
```

## Pastas

### iso-files
Uma śerie de scripts feitos para o momento da live da imagem.
O objetivo é facilitar o trabalho a ser feito nesse ambiente live.

#### Initial configs
Esse script carrega todas as configurações básicas para os teclados abnt2 e traz o português como língua.
Além disso, facilita a conexão à uma rede wifi se necessário.
Ao final inicializa o `cfdisk` para ajudar no particionamento dos HDs.
É recomendável o uso de partições do tipo ext4.

Após terminar o particionamento formate as partições com o sistema de arquivos selecionado em cada.
Exemplo:
```
mkfs.ext4 /dev/<partição>
```
Aperte `<Tab>` após o ponto para ver quais tipos de sistemas estão disponíveis.
Se tiver feito uma partição para swap, formate-a também.
```
mksap /dev/<partição>
```
Ative a swap
```
swapon /dev/<partição>
```
Terminado o particionamento e formatação, monte os sistemas de arquivos no diretório `/mnt`
```
mount /mnt  /dev/<partição>
```
Caso tenha separado partições diferentes para pastas diferentes, é aqui que deve organizar.
Exemplo:
```
mount /mnt /dev/sda1
mount /mnt/boot /dev/sda2
```

#### base-install
Após a formatação e montagem das partições, use esse arquivo para iniciar a instalação base do SO de maneira enxulta.

Reinicie o computador e use as `install-files` a partir daqui

### Install-files
Uma série de scripts e configurações para continuar a instalação após instalar as bases do sistema.

#### packages
Uma lista dos pacotes a serem instalados ao usar o system install.
Caso queira personalisar a instalação, altere os itens dessa lista adicionando ou removendo os pacotes na lista. 
Uma linha para cada pacote.

#### system-install
Esse script cuida de instalar os pacotes e configurar toda a base do sistema. 
É o script base dessa pasta.
Ele executa o script base-configurations automaticamente.


#### base-configurations
Responsável por organizar o fuso horário, mapeamento de teclado, nome do computador na rede, hosts, nome e senha do novo usuário.
Como o nome já diz, as configurações básicas do sistema.
