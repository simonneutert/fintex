defmodule FinTex.User.FinCredentials do

  alias FinTex.Model.Credentials

  @moduledoc """
    Provides a default implementation of the `FinTex.Model.Credentials` protocol.

    The following fields are public:
    * `login`     - user name
    * `client_id` - client ID. Can be `nil`.
    * `pin`       - personal identification number
  """

  @type t :: %__MODULE__{
    login: binary,
    client_id: binary | nil,
    pin: binary
  }

  defstruct [
    :login,
    :client_id,
    :pin
  ]
  use Vex.Struct

  validates :login, presence: true,
                    length: [min: 1, max: 255]

  validates :client_id, length: [min: 1, max: 255, allow_nil: true]

  validates :pin, presence: true,
                  length: [min: 1, max: 255]

  @doc false
  @spec from_credentials(Credentials.t) :: t
  def from_credentials(credentials) do
    %__MODULE__{
      login:     credentials |> Credentials.login,
      client_id: client_id(credentials |> Credentials.login, credentials |> Credentials.client_id),
      pin:       credentials |> Credentials.pin
    }
  end


  defp client_id(login, nil), do: login

  defp client_id(_, client_id), do: client_id

end


defimpl FinTex.Model.Credentials, for: FinTex.User.FinCredentials do

  def login(credentials) do
    credentials.login
  end


  def client_id(credentials) do
    credentials.client_id
  end


  def pin(credentials) do
    credentials.pin
  end
end
