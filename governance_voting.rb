class GovernanceVoting
  def initialize
    @proposals = []
    @votes = {}
    @proposal_id = 1
  end

  def create_proposal(title, description, creator)
    proposal = {
      id: @proposal_id,
      title: title,
      description: description,
      creator: creator,
      status: 'active',
      start_time: Time.now.to_i,
      end_time: Time.now.to_i + 86400 * 7
    }
    @proposals << proposal
    @proposal_id += 1
    proposal[:id]
  end

  def vote(proposal_id, voter, choice)
    return false unless proposal_valid?(proposal_id)

    @votes[proposal_id] ||= {}
    @votes[proposal_id][voter] = choice
    true
  end

  def get_results(proposal_id)
    votes = @votes[proposal_id] || {}
    votes.values.tally
  end

  private

  def proposal_valid?(proposal_id)
    proposal = @proposals.find { |p| p[:id] == proposal_id }
    proposal && proposal[:status] == 'active' && Time.now.to_i < proposal[:end_time]
  end
end
