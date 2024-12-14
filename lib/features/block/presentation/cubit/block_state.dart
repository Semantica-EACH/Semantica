part of 'block_cubit.dart';

abstract class BlockState extends Equatable {
  final Block block;

  const BlockState(this.block);

  @override
  List<Object> get props => [block];
}

class BlockViewing extends BlockState {
  const BlockViewing(Block block) : super(block);
}

class BlockEditing extends BlockState {
  const BlockEditing(Block block) : super(block);
}
