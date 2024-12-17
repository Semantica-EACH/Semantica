import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:semantica/features/block/domain/entities/block.dart';

part 'block_state.dart';

class BlockCubit extends Cubit<BlockState> {
  BlockCubit(Block block) : super(BlockViewing(block));

  void enterEditMode() {
    emit(BlockEditing(state.block));
  }

  void returnToViewing() {
    emit(BlockViewing(state.block));
  }

  void saveBlock(String newContent) {
    final updatedBlock = Block.fromMarkdown(newContent);
    emit(BlockEditing(updatedBlock));
  }
}
