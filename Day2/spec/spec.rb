require_relative '../main'

RSpec.describe PuzzleSolver do
  subject(:solver) { described_class.allocate } # skip initialize (kein File-Read)

  describe '#equal?' do
    it 'liefert true, wenn beide hälften identisch sind' do
      expect(solver.equal?(11)).to be true
      expect(solver.equal?(22)).to be true
      expect(solver.equal?(1010)).to be true
      expect(solver.equal?(1188511885)).to be true
      expect(solver.equal?(222222)).to be true
      expect(solver.equal?(446446)).to be true
      expect(solver.equal?(38593859)).to be true
    end

    it 'liefert false, wenn sich die hälften unterscheiden' do
      expect(solver.equal?(1234)).to be false
      expect(solver.equal?(1214)).to be false
      expect(solver.equal?(1234112231)).to be false
      expect(solver.equal?(123211132)).to be false
      expect(solver.equal?(1698528)).to be false
      expect(solver.equal?(1698522)).to be false
    end
  end
end