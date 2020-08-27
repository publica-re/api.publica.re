defmodule ApiWeb.UserView do
  use ApiWeb, :view
  alias ApiWeb.UserView

  def render("index.json", %{users: users, auth: %{jwt: jwt, claims: claims}}) do
    %{data: render_many(users, UserView, "user.json"), jwt: jwt, claims: claims}
  end

  def render("show.json", %{user: user, auth: %{jwt: jwt, claims: claims}}) do
    %{data: render_one(user, UserView, "user.json"), jwt: jwt, claims: claims}
  end

  def render("user.json", %{user: user}) do
    %{
      uid: user.uid,
      title: user.title,
      displayName: user.displayName,
      givenName: user.givenName,
      surname: user.surname,
      initials: user.initials,
      description: user.description,
      labeledURI: user.labeledURI,
      mail: user.mail,
      jpegPhoto:
        if user.jpegPhoto !== nil do
          "data:image/jpeg;base64," <> Base.encode64(user.jpegPhoto)
        else
          nil
        end,
      photo: Base.encode64(user.photo || ""),
      preferredLanguage: user.preferredLanguage,
      mobile: user.mobile,
      telephoneNumber: user.telephoneNumber,
      businessCategory: user.businessCategory,
      employeeNumber: user.employeeNumber,
      employeeType: user.employeeType,
      organizationName: user.organizationName,
      userCertificate: user.userCertificate,
      postalAddress: user.postalAddress,
      postOfficeBox: user.postOfficeBox,
      postalCode: user.postalCode,
      localityName: user.localityName,
      preferredDeliveryMethod: user.preferredDeliveryMethod,
      stateOrProvinceName: user.stateOrProvinceName,
      seeAlso: user.seeAlso
    }
  end
end
