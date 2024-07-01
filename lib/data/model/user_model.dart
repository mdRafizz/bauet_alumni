class UserModel {
  final String? bloodGroup;
  final String? bscDegree;
  final String? bscDuration;
  final String? bscInstitution;
  final String? currentStatus;
  final String? dob;
  final String? email;
  final String? experiencePosition;
  final String? firstName;
  final String? hometown;
  final String? hscDuration;
  final String? hscInstitution;
  final String? id;
  final String? institute;
  final String? lastName;
  final List<String>? mentorOfferings;
  final String? mscDegree;
  final String? mscDuration;
  final String? mscInstitution;
  final String? password;
  final String? phdDuration;
  final String? phdInstitution;
  final String? phdSubject;
  final String? phoneNumber;
  final String? profilePictureUrl;
  final String? sscDuration;
  final String? sscInstitution;
  final String? studentId;
  final String? wantToMentor;
  final String? whatsappNumber;
  final String? coverPictureUrl;
  final String? role;

  UserModel({
    this.coverPictureUrl,
    this.bloodGroup,
    this.bscDegree,
    this.bscDuration,
    this.bscInstitution,
    this.currentStatus,
    this.dob,
    this.email,
    this.experiencePosition,
    this.firstName,
    this.hometown,
    this.hscDuration,
    this.hscInstitution,
    this.id,
    this.institute,
    this.lastName,
    this.mentorOfferings,
    this.mscDegree,
    this.mscDuration,
    this.mscInstitution,
    this.password,
    this.phdDuration,
    this.phdInstitution,
    this.phdSubject,
    this.phoneNumber,
    this.profilePictureUrl,
    this.sscDuration,
    this.sscInstitution,
    this.studentId,
    this.wantToMentor,
    this.whatsappNumber,
    this.role = 'user',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      coverPictureUrl: json['coverPictureUrl'],
      bloodGroup: json['bloodGroup'],
      bscDegree: json['bscDegree'],
      bscDuration: json['bscDuration'],
      bscInstitution: json['bscInstitution'],
      currentStatus: json['currentStatus'],
      dob: json['dob'],
      email: json['email'],
      experiencePosition: json['experiencePosition'],
      firstName: json['firstName'],
      hometown: json['hometown'],
      hscDuration: json['hscDuration'],
      hscInstitution: json['hscInstitution'],
      id: json['id'],
      institute: json['institute'],
      lastName: json['lastName'],
      mentorOfferings: json['mentorOfferings'] != null
          ? List<String>.from(json['mentorOfferings'])
          : null,
      mscDegree: json['mscDegree'],
      mscDuration: json['mscDuration'],
      mscInstitution: json['mscInstitution'],
      password: json['password'],
      phdDuration: json['phdDuration'],
      phdInstitution: json['phdInstitution'],
      phdSubject: json['phdSubject'],
      phoneNumber: json['phoneNumber'],
      profilePictureUrl: json['profilePictureUrl'],
      sscDuration: json['sscDuration'],
      sscInstitution: json['sscInstitution'],
      studentId: json['studentId'],
      wantToMentor: json['wantToMentor'],
      whatsappNumber: json['whatsappNumber'],
      role: json['role'],
    );
  }
}
