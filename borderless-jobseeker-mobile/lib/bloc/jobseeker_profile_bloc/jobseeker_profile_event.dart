part of 'jobseeker_profile_bloc.dart';

abstract class JobseekerProfileEvent extends Equatable {
  const JobseekerProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateSelfIntroButtonPressed extends JobseekerProfileEvent {
  final String video;
  final String selfpr;
  final String faceimageprivatestatus;
  final bool deletefacimage;
  final File faceimage;
  final List<String> deleterelatedimages;
  final List relatedimages;

  const UpdateSelfIntroButtonPressed({
    @required this.video,
    @required this.selfpr,
    @required this.faceimageprivatestatus,
    @required this.deletefacimage,
    @required this.faceimage,
    @required this.deleterelatedimages,
    @required this.relatedimages,
  });

  @override
  List<Object> get props => [
        video,
        selfpr,
        faceimageprivatestatus,
        deletefacimage,
        faceimage,
        deleterelatedimages,
        relatedimages,
      ];

  @override
  String toString() =>
      'UpdateSelfIntroButtonPressed { video: $video, self_pr: $selfpr, face_image_private_status: $faceimageprivatestatus, delete_fac_image:$deletefacimage,face_image:$faceimage, delete_related_images: $deleterelatedimages, related_images: $relatedimages}';
}

class InitialState extends JobseekerProfileEvent {
  @override
  List<Object> get props => [];
}

class GetSelfIntroList extends JobseekerProfileEvent {
  @override
  List<Object> get props => null;
}

class GetExpQualification extends JobseekerProfileEvent {
  @override
  List<Object> get props => null;
}
