<#import "template.ftl" as layout>
<@layout.mainLayout active='applications' bodyClass='applications'; section>
    <div class="DashboardProfilePictureWrapper">
        <div class="DashboardProfilePicture">
            <figure class="ProfileContent">
                <img alt="Profile"
                     style="display: none"
                     id="profileImage"
                     width="96"
                     height="96" src="">
            </figure>
            <div class="ChangeGravatar" onclick="handleChangeAvatar()">
                <div></div>
            </div>
        </div>
    </div>

    <h1 class="GreetingsMessage" style="display: none" id="greetingsMessage">
        Good <span id="afterTime"></span>, <b class="Username">${ account.firstName! }</b>
    </h1>

    <form action="${url.applicationsUrl}" method="post">
        <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
        <input type="hidden" id="referrer" name="referrer" value="${stateChecker}">

        <div class="CardList">
            <#list applications.applications as application>
                <#if application.effectiveUrl?has_content>
                    <a class="bx--tile bx--tile--clickable Card" href="${application.effectiveUrl}">
                        <svg focusable="false" preserveAspectRatio="xMidYMid meet" style="will-change: transform;"
                             class="Icon"
                             xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32"
                             aria-hidden="true">
                            <path d="M16 18H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2zM6 6v10h10V6zm20 6v4h-4v-4h4m0-2h-4a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2h4a2 2 0 0 0 2-2v-4a2 2 0 0 0-2-2zm0 12v4h-4v-4h4m0-2h-4a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2h4a2 2 0 0 0 2-2v-4a2 2 0 0 0-2-2zm-10 2v4h-4v-4h4m0-2h-4a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2h4a2 2 0 0 0 2-2v-4a2 2 0 0 0-2-2z"></path>
                        </svg>
                        <span>
                            <#if application.client.name?has_content>${advancedMsg(application.client.name)}<#else>${application.client.clientId}</#if>
                        </span>
                    </a>
                </#if>
            </#list>
        </div>

        <h2 style="margin-top: 1em;">Application manager</h2>
        <div data-notification="" class="bx--inline-notification bx--inline-notification--warning" role="alert">
            <div class="bx--inline-notification__details">
                <svg focusable="false" preserveAspectRatio="xMidYMid meet" style="will-change: transform;"
                     xmlns="http://www.w3.org/2000/svg" class="bx--inline-notification__icon" width="20" height="20"
                     viewBox="0 0 20 20" aria-hidden="true">
                    <path d="M10,1c-5,0-9,4-9,9s4,9,9,9s9-4,9-9S15,1,10,1z M9.2,5h1.5v7H9.2V5z M10,16c-0.6,0-1-0.4-1-1s0.4-1,1-1	s1,0.4,1,1S10.6,16,10,16z"></path>
                    <path d="M9.2,5h1.5v7H9.2V5z M10,16c-0.6,0-1-0.4-1-1s0.4-1,1-1s1,0.4,1,1S10.6,16,10,16z"
                          data-icon-path="inner-path" opacity="0"></path>
                </svg>
                <div class="bx--inline-notification__text-wrapper">
                    <p class="bx--inline-notification__title">This is experimental and for advanced users only</p>
                    <p class="bx--inline-notification__subtitle">Please be careful when using this, as it can cause
                        major data loss.</p>
                </div>
            </div>
        </div>

        <section class="bx--structured-list">
            <div class="bx--structured-list-thead">
                <div class="bx--structured-list-row bx--structured-list-row--header-row">
                    <div class="bx--structured-list-th">${msg("application")}</div>
                    <div class="bx--structured-list-th">${msg("availableRoles")}</div>
                    <div class="bx--structured-list-th">${msg("grantedPermissions")}</div>
                    <div class="bx--structured-list-th">${msg("additionalGrants")}</div>
                    <div class="bx--structured-list-th">${msg("action")}</div>
                </div>
            </div>
            <div class="bx--structured-list-tbody">
                <#list applications.applications as application>
                    <div class="bx--structured-list-row">
                        <div class="bx--structured-list-td bx--structured-list-content--nowrap">
                            <#if application.effectiveUrl?has_content><a href="${application.effectiveUrl}"></#if>
                                <#if application.client.name?has_content>${advancedMsg(application.client.name)}<#else>${application.client.clientId}</#if>
                                <#if application.effectiveUrl?has_content></a></#if>
                        </div>

                        <div class="bx--structured-list-td">
                            <#list application.realmRolesAvailable as role>
                                <#if role.description??>${advancedMsg(role.description)}<#else>${advancedMsg(role.name)}</#if>
                                <#if role_has_next>, </#if>
                            </#list>
                            <#list application.resourceRolesAvailable?keys as resource>
                                <#if application.realmRolesAvailable?has_content>, </#if>
                                <#list application.resourceRolesAvailable[resource] as clientRole>
                                    <#if clientRole.roleDescription??>${advancedMsg(clientRole.roleDescription)}<#else>${advancedMsg(clientRole.roleName)}</#if>
                                    ${msg("inResource")}
                                    <strong><#if clientRole.clientName??>${advancedMsg(clientRole.clientName)}<#else>${clientRole.clientId}</#if></strong>
                                    <#if clientRole_has_next>, </#if>
                                </#list>
                            </#list>
                        </div>

                        <div class="bx--structured-list-td">
                            <#if application.client.consentRequired>
                                <#list application.clientScopesGranted as claim>
                                    ${advancedMsg(claim)}<#if claim_has_next>, </#if>
                                </#list>
                            <#else>
                                <strong>${msg("fullAccess")}</strong>
                            </#if>
                        </div>

                        <div class="bx--structured-list-td">
                            <#list application.additionalGrants as grant>
                                ${advancedMsg(grant)}<#if grant_has_next>, </#if>
                            </#list>
                        </div>

                        <div class="bx--structured-list-td">
                            <#if (application.client.consentRequired && application.clientScopesGranted?has_content) || application.additionalGrants?has_content>
                                <button type='submit'
                                        class='${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!}'
                                        id='revoke-${application.client.clientId}' name='clientId'
                                        value="${application.client.id}">${msg("revoke")}</button>
                            </#if>
                        </div>
                    </div>
                </#list>
            </div>
        </section>
    </form>

</@layout.mainLayout>
