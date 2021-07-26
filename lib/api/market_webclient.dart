class MarketWebClient {
  Future<dynamic> getAllProducts() async {
    return [
      {
        "id": 1,
        "name": "Maçã",
        "value": 1.50,
        "image":
            "https://feirafeita.com.br/media/catalog/product/cache/12/image/9df78eab33525d08d6e5fb8d27136e95/c/a/captura_de_tela_2018-01-22_a_s_09.34.59.png",
      },
      {
        "id": 2,
        "name": "Pêra",
        "value": 2.50,
        "image":
            "https://static3.tcdn.com.br/img/img_prod/450860/1288_1_20190611093627.jpg"
      },
      {
        "id": 3,
        "name": "Banana",
        "value": 0.75,
        "image":
            "https://hiperideal.vteximg.com.br/arquivos/ids/171306-1000-1000/12696.jpg?v=636626179776100000"
      },
      {
        "id": 4,
        "name": "Abacaxi",
        "value": 3.50,
        "image":
            "https://superprix.vteximg.com.br/arquivos/ids/175201-292-292/Abacaxi--unidade-.png?v=636294199507870000"
      },
      {
        "id": 5,
        "name": "Manga",
        "value": 1.25,
        "image":
            "https://saberhortifruti.com.br/wp-content/uploads/2020/05/manga-tipo-rosa.jpg"
      },
    ];
  }
}
