
import 'package:canteens_fusion/core/core.dart';
import 'package:canteens_fusion/features/auth/domain/entities/user_entity.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/domain/repositories/signup_repo.dart';
import 'package:canteens_fusion/features/auth/sub_features/sign_up/domain/usecases/params.dart';

class SignupRegisterUserUseCase implements UseCase<UserEntity,SignupRegisterUserParams>{
  final SignupRepo _signupRepo;

  SignupRegisterUserUseCase(this._signupRepo);

  @override
  Future<UserEntity> call(SignupRegisterUserParams params) async{
    return await _signupRepo.registerUser(params);
  }

}