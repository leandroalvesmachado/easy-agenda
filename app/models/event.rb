class Event < ApplicationRecord
  enum status: { active: "active", removed: "removed" }

  belongs_to :category, class_name: "Category", foreign_key: "category_id"

  # se o relacionamento fosse opcional, pode ser nulo
  # belongs_to :category, optional: true, class_name: "Category", foreign_key: "category_id"

  validates :name, presence: true
  validates :name, length: {  minimum: 3, maximum: 100, allow_blank: true } # allow_blank: true só aplica quando o campo não for vazio
  validates :started_at, presence: true
  validates :finished_at, presence: true

  # validação personalizada
  # "on" serve para informar em qual método aplicar a validação, no caso no create
  validate :validate_if_start_in_future, on: :create
  validate :validate_if_finished_greater_than_started

  # retornar o evento já com a category do relacionamento
  scope :with_category, -> { includes(:category) }

  # retorna todos os eventos do dia atual
  scope :today, -> { where("started_at >= ? AND started_at <= ?", Date.current.beginning_of_day, Date.current.end_of_day) }

  # com argumentos, para passar parâmetros
  scope :in_period, ->(period_start, period_end) { where("started_at >= ? AND started_at <= ?") }

  # active storage
  has_one_attached :file

  # action text
  has_rich_text :description

  private

  def validate_if_finished_greater_than_started
    return unless started_at
    return unless finished_at
    return if finished_at > started_at

    # realizando debug com o byebug
    # next - Avança para a próxima linha.
    # continue - Continua a execução até o próximo breakpoint ou o final.
    # break - Define um novo breakpoint.
    # list - Mostra as linhas de código ao redor do ponto atua

    # debugger

    errors.add(:finished_at, "Não pode ser menor que Started")
  end

  def validate_if_start_in_future
    return unless started_at
    return if started_at >= Time.now

    # adicionando mensagem de erro ao campo
    errors.add(:started_at, :invalid)
  end
end
