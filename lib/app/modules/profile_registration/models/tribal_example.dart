/* model of tribal example for the registration */

class TribeProfileExamples {
  const TribeProfileExamples.profileDescription({
    required this.description,
    required this.imageAssetPath,
    required this.tribeName,
    required this.userName,
  });

  final String imageAssetPath;
  final String userName;
  final String tribeName;
  final String description;

  void addProfileDescription(String description, String tribeName,
      String userName, String tribalSignPath) {
    listTribeProfileExamples.add(TribeProfileExamples.profileDescription(
        description: description,
        imageAssetPath: tribalSignPath,
        tribeName: tribeName,
        userName: userName));
  }

/* List of models for example description in the registration  */
  static List<TribeProfileExamples> listTribeProfileExamples = [
    const TribeProfileExamples.profileDescription(
        description:
            "What are you working on? What brings you to the tribe? What is your occupation / profession / employment ? What is your age? What makes you happy? What gives you joy? Where are you? What is your local time? What time would you like to spend with the tribe? What would you like to know about other members?",
        imageAssetPath:
            'assets/images/authorization_screen/tribel_signs/question_hints.png',
        tribeName: 'Question to anwser',
        userName: 'ALL'),
    const TribeProfileExamples.profileDescription(
        description:
            "I'm here looking for writers who are interested in collective poetry practices. I've been writing and teaching writing for about 25 years. One thing that I enjoy is sharing and swapping writing projects. I'm in Chicago, which is +7 GMT. I hope to spend a few hours each week working on writing projects and meeting other members. I would spend Sunday afternoons participating in the tribe. I would like to know what kind of writing other members are doing. Right now, I'm dividing my time between experimental poetry and weird fiction. ",
        imageAssetPath:
            'assets/images/authorization_screen/tribel_signs/writer_tribe.png',
        tribeName: 'Writers Tribe',
        userName: 'Aetios'),
    const TribeProfileExamples.profileDescription(
        description:
            "I've been making music for thirty years. I teach guitar, piano, drums and voice. I have worked with many professional musicians and recorded several albums. Classical metal is my jam, but I listen to everything that's worth a damn. I'm looking to swap stories with other musicians and give advice to the new beginners. I live in the U.S.A. in the Pacific northwest. My time zone is GMT -8. I plan to check in whenever I can - mostly when I'm at work :)  Playing guitar is what gives me joy. I guess I just want to know what everyone is listening to. ",
        imageAssetPath:
            'assets/images/authorization_screen/tribel_signs/musical_tribe.png',
        tribeName: 'Musical Tribe',
        userName: 'Hellena'),
    const TribeProfileExamples.profileDescription(
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        imageAssetPath:
            'assets/images/authorization_screen/tribel_signs/photography_tribe.png',
        tribeName: 'Photographer Tribe',
        userName: 'Achilles'),
    const TribeProfileExamples.profileDescription(
        description:
            "Hi! We are a couple from Germany. We have both been retired for three years now--and we have spent as much of that time traveling as we can. We are attempting to visit each continent (except Antarctica!) in our caravan, and looking for other travelers who are doing the same. Who knows--we might even be able to meet on the road. For the next six months, we are visiting Australia. Our location will change every week.  We started in Perth and spent a week near Bremer Bay. Next we plan to travel along the coast to Cape Le Grand, then head north to Dundas Reserve. We'll check in as often as we can. We would like to know your travel plans, especially if you are currently down under.",
        imageAssetPath:
            'assets/images/authorization_screen/tribel_signs/traveller_tribe.png',
        tribeName: 'Traveller Tribe',
        userName: 'Cornelius'),
    const TribeProfileExamples.profileDescription(
        description:
            "I am a 30-year old mother of a three-year old boy. My son just started day care at a local school. I'm looking for new ways to raise a child in this world. Right now, parenting takes up most of my time, but I will be going back to school when they are old enough. To all the parents out there, I would like to learn your philosophies of child care.  I grew up in southern Mexico, but I live in California, U.S. My time zone is Western Standard Time (GMT -8). I would like to spend a couple of hours each day to learn about parenting from around the world. ",
        imageAssetPath:
            'assets/images/authorization_screen/tribel_signs/mothering_tribe.png',
        tribeName: 'Mothering Tribe',
        userName: 'Persephona'),
    const TribeProfileExamples.profileDescription(
        description:
            " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        imageAssetPath:
            'assets/images/authorization_screen/tribel_signs/illness_tribe.png',
        tribeName: 'Illnes Tribe',
        userName: 'Priam'),
    const TribeProfileExamples.profileDescription(
        description:
            "I'm looking for people to become part of a new business. I would like to be with like-minded people who share my perception of the world. My dream is to build a communal business that combines living with improving the world. I'm currently building and improving the Online-tribes. I'm a young (27) entrepreneur and programmer. Having really good and nice people around me brings me joy. My time zone is UTC+7  - Chaing Mai, Thailand. I would like to spend from five am to midnight, seven days a week with the tribe. Thich Nhat Hanh says that \"love is about looking in the same direction.\" I would love to have many people around me looking in the same direction. ",
        imageAssetPath:
            'assets/images/authorization_screen/tribel_signs/business_tribe.png',
        tribeName: 'Business Tribe',
        userName: 'Ajax'),
    const TribeProfileExamples.profileDescription(
        description:
            "I'm 21. I am a graphic designer, with experience in Photoshop, Illustrator and LightRoom. I also edit videos in Filmora and Premier Pro. I have designed many logos for various companies and am currently working on several commercials. I'm looking for fresh perspectives and potential partners to collaborate on some projects I have in mind. My happiness comes from pleasing my customers by realizing their ideas. I am proud of my work and constantly looking to improve. I live in Lahore, which is GMT+5. The amount of time I can spend on the tribe will depend on my assignments, but I look forward to learning with all of you!",
        imageAssetPath:
            'assets/images/authorization_screen/tribel_signs/artist_tribe.png',
        tribeName: 'Artist Tribe',
        userName: 'Lydhia'),
  ];
}
